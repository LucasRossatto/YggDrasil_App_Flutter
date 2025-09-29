import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'package:yggdrasil_app/src/models/arvore_model.dart';
import 'package:yggdrasil_app/src/services/localizacao_service.dart';
import 'package:yggdrasil_app/src/shared/widgets/custom_snackbar.dart';
import 'package:yggdrasil_app/src/view/widgets/adicionar_arvore_form.dart';
import 'package:yggdrasil_app/src/view/widgets/scanner_screen.dart';
import 'package:yggdrasil_app/src/viewmodel/arvore_viewmodel.dart';

class AdicionarArvoreScreen extends StatefulWidget {
  final int usuarioId;

  const AdicionarArvoreScreen({super.key, required this.usuarioId});

  @override
  State<AdicionarArvoreScreen> createState() => _AdicionarArvoreScreen();
}

class _AdicionarArvoreScreen extends State<AdicionarArvoreScreen> {
  late TextEditingController tagArvore;

  @override
  void initState() {
    super.initState();
    tagArvore = TextEditingController();
    _requestLocationDialogIfAndroid();
  }

  @override
  void dispose() {
    tagArvore.dispose();
    super.dispose();
  }

  Future<void> _requestLocationDialogIfAndroid() async {
    if (!Platform.isAndroid) return;

    // Aqui mostramos o diálogo explicativo antes de pedir permissão
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Precisamos da sua localização"),
        content: const Text(
          "Para cadastrar a árvore automaticamente com a sua posição, precisamos acessar sua localização.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Continuar"),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Solicita permissão depois do diálogo
      await Permission.location.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final usuarioId = widget.usuarioId;
    final arvoreVm = context.read<ArvoreViewModel>();

    void abrirScanner() async {
      final result = await Navigator.of(
        context,
      ).push<String>(MaterialPageRoute(builder: (_) => const ScannerScreen()));
      if (result != null && result.isNotEmpty) {
        tagArvore.text = result;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Adicionar Árvore")),

      body: Column(
        children: [
          ArvoreCreateForm(
            tagIdController: tagArvore,
            arvore: ArvoreModel(
              usuarioId: usuarioId,
              tagId: tagArvore.text,
              imagemURL: '',
              nome: '',
              mensagem: '',
              familia: '',
              idadeAproximada: '',
              localizacao: '',
              nota: 0,
              tipo: 0,
            ),
            onSubmit: (arvore) async {
              try {
                final localizacaoAtual =
                    await LocalizacaoService.getCurrentLocation();

                if (localizacaoAtual == null) {
                  CustomSnackBar.show(
                    context,
                    message: "Não foi possível obter a localização Atual.",
                  );
                  return;
                }

                final arvoreComLocalizacao = arvore.copyWith(
                  localizacao: localizacaoAtual,
                );

                final sucesso = await arvoreVm.cadastrarArvore(
                  arvoreComLocalizacao,
                );

                if (!sucesso) {
                  CustomSnackBar.show(
                    context,
                    backgroundColor: theme.colorScheme.onError,
                    message: "Erro ao cadastrar árvore: ${arvoreVm.erro}",
                    icon: Icons.error,
                  );
                } else {
                  CustomSnackBar.show(
                    context,
                    message: "Árvore cadastrada com sucesso! 🌱",
                    icon: Icons.check_circle,
                  );
                }

                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pop();
                });
              } catch (e) {
                CustomSnackBar.show(
                  context,
                  backgroundColor: theme.colorScheme.onError,
                  icon: Icons.error_outline,
                  message: "Erro ao obter localização: $e",
                );
              }
            },
            abrirScanner: abrirScanner,
          ),
        ],
      ),
    );
  }
}
