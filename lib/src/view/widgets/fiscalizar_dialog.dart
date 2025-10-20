import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/models/arvore_model.dart';
import 'package:yggdrasil_app/src/models/avaliacao_model.dart';
import 'package:yggdrasil_app/src/shared/widgets/app_text_field.dart';
import 'package:yggdrasil_app/src/shared/widgets/condicao_arvore_drowdownbutton.dart';
import 'package:yggdrasil_app/src/shared/widgets/custom_snackbar.dart';
import 'package:yggdrasil_app/src/shared/widgets/gradient_appbar.dart';
import 'package:yggdrasil_app/src/shared/widgets/camera_button_wrapper.dart';
import 'package:yggdrasil_app/src/viewmodel/arvore_viewmodel.dart';

class AvaliacaoDialog extends StatefulWidget {
  final int usuarioId;
  final ArvoreModel arvore;

  const AvaliacaoDialog({
    super.key,
    required this.usuarioId,
    required this.arvore,
  });

  @override
  State<AvaliacaoDialog> createState() => _AvaliacaoDialogState();
}

class _AvaliacaoDialogState extends State<AvaliacaoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _condicaoController = TextEditingController();
  final _comentarioController = TextEditingController();
  String? imagemAvaliacao;
  int _nota = 0;

  // Função para confirmar descartar avaliação
  Future<bool> _confirmDiscard() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Deseja realmente descartar a avaliação?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "As informações que você inseriu não serão salvas.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.error,
              ),
            ),
            child: Text(
              "Descartar",
              style: TextStyle(color: Theme.of(context).colorScheme.errorContainer),
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // Função para tentar fechar a tela
  Future<void> _tryClose() async {
    final discard = await _confirmDiscard();
    if (discard) Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final vmArvore = context.watch<ArvoreViewModel>();
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Scaffold(
          appBar: GradientAppBar(
            title: "Nova Fiscalização",
            leading: IconButton(
              icon: Icon(Icons.close),
              color: theme.colorScheme.surface,
              onPressed: _tryClose, // chama confirmação antes de fechar
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tire uma foto para registrar a fiscalização",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CameraButtonWrapper(
                    onImageCaptured: (base64Image) {
                      setState(() {
                        imagemAvaliacao = base64Image;
                      });
                    },
                  ),
                  if (imagemAvaliacao != null)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(8),
                        ),

                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10.0,
                          children: [
                            SizedBox(width: 1),
                            Icon(Icons.check_circle, color: Colors.green[800]),
                            Text(
                              "Foto da árvore registrada",
                              style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 1),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  // se for fiscal é false
                  CondicaoArvoreDropdown(
                    controller: _condicaoController,
                    isLeigo: true,
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    controller: _comentarioController,
                    extraLabel: 'Observações',
                    label:
                        'Ex.: Pequenos galhos quebrados, sinais de pragas...',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Informe suas observações";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nota: $_nota"),
                      Slider(
                        min: 0,
                        max: 5,
                        divisions: 5,
                        value: _nota.toDouble(),
                        label: "$_nota",
                        onChanged: (value) {
                          setState(() => _nota = value.toInt());
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed:
                            _tryClose, // confirmação ao clicar em cancelar
                        child: const Text("Cancelar"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            theme.colorScheme.primary,
                          ),
                        ),
                        onPressed: () async {
                                if (!_formKey.currentState!.validate()) return;

                                // Valida imagem
                                if (imagemAvaliacao == null) {
                                  CustomSnackBar.show(
                                    context,
                                    profile: 'warning',
                                    message:
                                        "Para fiscalizar, Tire uma foto da Árvore",
                                  );
                                  return;
                                }

                                // Valida nota
                                if (_nota == 0) {
                                  CustomSnackBar.show(
                                    context,
                                    profile: 'warning',
                                    message: "Escolha uma nota maior que 0",
                                  );
                                  return;
                                }
                                final avaliacao = AvaliacaoModel(
                                  tag: widget.arvore.tag.epc,
                                  usuarioId: widget.usuarioId,
                                  imagemValidacao: imagemAvaliacao.toString(),
                                  condicaoAtual: _condicaoController.text
                                      .trim(),
                                  comentario: _comentarioController.text.trim(),
                                  dataAvaliacao: DateTime.now(),
                                  nota: _nota,
                                );

                                final res = await vmArvore.fiscalizar(
                                  avaliacao,
                                );

                                if (res != null) {
                                  CustomSnackBar.show(
                                    context,
                                    message:
                                        'Fiscalização realizada com sucesso!',
                                  );
                                  Navigator.pop(context, avaliacao);
                                } else {
                                  CustomSnackBar.show(
                                    context,
                                    profile: 'error',
                                    message:
                                        vmArvore.erro ??
                                        "Ocorreu um erro inesperado.",
                                  );
                                }
                              },
                        child: vmArvore.isLoading
                            ? SizedBox(
                                height: 17,
                                width: 17,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              )
                            : Text(
                                "Enviar Avaliação",
                                style: TextStyle(
                                  color: theme.colorScheme.surface,
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
