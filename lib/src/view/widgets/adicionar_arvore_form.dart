import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:YggDrasil/src/models/arvore_model.dart';
import 'package:YggDrasil/src/shared/widgets/app_numeric_field.dart';
import 'package:YggDrasil/src/shared/widgets/app_text_field.dart';
import 'package:YggDrasil/src/shared/widgets/custom_snackbar.dart';
import 'package:YggDrasil/src/shared/widgets/tipo_arvore_segmentedbutton.dart';
import 'package:YggDrasil/src/view/widgets/transferir_button.dart';
import 'package:YggDrasil/src/viewmodel/arvore_viewmodel.dart';

class ArvoreCreateForm extends StatefulWidget {
  final ArvoreModel arvore;
  final TextEditingController tagIdController;
  final VoidCallback abrirScanner;
  final void Function(ArvoreModel) onSubmit;

  const ArvoreCreateForm({
    super.key,
    required this.arvore,
    required this.onSubmit,
    required this.tagIdController,
    required this.abrirScanner,
  });

  @override
  State<ArvoreCreateForm> createState() => _ArvoreCreateFormState();
}

class _ArvoreCreateFormState extends State<ArvoreCreateForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nomeController;
  late TextEditingController familiaController;
  late TextEditingController idadeAproximadaController;
  late TextEditingController historicoController;
  late TextEditingController tipoController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.arvore.nome);
    familiaController = TextEditingController(text: widget.arvore.familia);
    idadeAproximadaController = TextEditingController(
      text: widget.arvore.idadeAproximada,
    );
    tipoController = TextEditingController();
    historicoController = TextEditingController(text: widget.arvore.mensagem);
  }

  @override
  void dispose() {
    nomeController.dispose();
    familiaController.dispose();
    idadeAproximadaController.dispose();
    historicoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final paddingHorizontal = screenWidth * 0.05; // 5% da largura da tela
    final spacingVertical = screenHeight * 0.02; // 2% da altura da tela
    final vm = context.read<ArvoreViewModel>();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: spacingVertical,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spacingVertical),
            Text(
              "Tag",
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: AppTextField(
                    controller: widget.tagIdController,
                    label: "Digite ou escaneiro o QR code",
                    hint: "Digite a Tag da árvore ou escaneie o QR Code",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe uma tag válida";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: widget.abrirScanner,
                    iconSize: screenWidth * 0.08,
                    icon: SvgPicture.asset(
                      'assets/Icons/Icone_YGGTAGG.svg',
                      // ignore: deprecated_member_use
                      color: Theme.of(context).colorScheme.surface,
                      width: screenWidth * 0.08,
                      height: screenWidth * 0.08,
                    ),
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spacingVertical),
            AppTextField(
              controller: nomeController,
              label: "Nome",
              hint: "Nome da árvore",
              extraLabel: "Nome",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Informe um nome para a árvore";
                }
                return null;
              },
            ),
            SizedBox(height: spacingVertical),
            AppTextField(
              controller: familiaController,
              label: "Nome científico",
              hint: "Nome científico",
              extraLabel: "Nome científico",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Informe um Nome científico para a árvore";
                }
                return null;
              },
            ),
            SizedBox(height: spacingVertical),
            AppNumericField(
              controller: idadeAproximadaController,
              label: "Idade Aproximada",
              hint: "Idade da árvore",
              extraLabel: "Idade",
              validator: (value) {
                if (value == null || value == 0 || value.isEmpty) {
                  return "Informe uma idade para a árvore";
                }
                return null;
              },
            ),
            SizedBox(height: spacingVertical),

            TipoArvoreSegmented(label: "Tipo", tipoController: tipoController),
            SizedBox(height: spacingVertical),

            AppTextField(
              controller: historicoController,
              label: "História",
              hint: "Conte a história da árvore",
              extraLabel: "História",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Informe uma história para a árvore";
                }
                return null;
              },
            ),
            SizedBox(height: spacingVertical),
            SizedBox(
              width: double.infinity,
              child: TransferirButton(
                isLoading: vm.isLoading,
                text: "Criar Árvore",
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    CustomSnackBar.show(
                      context,
                      message: "Preencha todos os campos obrigatórios.",
                      profile: 'warning',
                    );
                    return;
                  }

                  final arvoreAtualizada = widget.arvore.copyWith(
                    tagId: widget.tagIdController.text,
                    imagemURL: '',
                    nome: nomeController.text,
                    familia: familiaController.text,
                    idadeAproximada: idadeAproximadaController.text,
                    nota: 1,
                    tipo: int.tryParse(tipoController.text) ?? 0,
                    mensagem: historicoController.text,
                  );

                  widget.onSubmit(arvoreAtualizada);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
