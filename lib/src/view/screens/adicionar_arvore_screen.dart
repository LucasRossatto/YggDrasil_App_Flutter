import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'package:yggdrasil_app/src/models/arvore_model.dart';
import 'package:yggdrasil_app/src/models/tag_model.dart';
import 'package:yggdrasil_app/src/services/localizacao_service.dart';
import 'package:yggdrasil_app/src/shared/widgets/custom_snackbar.dart';
import 'package:yggdrasil_app/src/view/widgets/adicionar_arvore_form.dart';
import 'package:yggdrasil_app/src/view/widgets/camera_button_wrapper.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleLocationRequest();
    });
  }

  @override
  void dispose() {
    tagArvore.dispose();
    super.dispose();
  }

  Future<void> _handleLocationRequest() async {
    final position = await _requestLocationIfAndroid(context);
    if (position != null) {
      final formatted = '${position.latitude} ${position.longitude}';
      print(formatted); // -> -23.5998668 -46.8548211
    }
  }

  Future<Position?> _requestLocationIfAndroid(BuildContext context) async {
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

    if (confirmed != true) return null;

    try {
      // Testa se os serviços estão habilitados
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return Future.error('Serviços de localização desativados.');
      }

      // Verifica permissões
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Permissão de localização negada.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
          'Permissão de localização negada permanentemente. Vá nas configurações para ativá-la.',
        );
      }

      // Tudo certo, obtém a posição atual
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      debugPrint('Erro ao obter localização: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final usuarioId = widget.usuarioId;
    final arvoreVm = context.read<ArvoreViewModel>();
    String? _base64Image;

    void abrirScanner() async {
      final result = await Navigator.of(
        context,
      ).push<String>(MaterialPageRoute(builder: (_) => const ScannerScreen()));
      if (result != null && result.isNotEmpty) {
        tagArvore.text = result;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Árvore"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 166, 62, 1),
                Color.fromRGBO(0, 122, 85, 1),
              ],
              stops: [0, 0.5],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            CameraButtonWrapper(
              onImageCaptured: (base64Image) {
                _base64Image = base64Image;
              },
            ),
            ArvoreCreateForm(
              tagIdController: tagArvore,
              arvore: ArvoreModel(
                id: 0,
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
                sccAcumulado: 0,
                sccGerado: 0,
                sccLiberado: 0,
                ultimaFiscalizacao: '',
                ultimaValidacao: '',
                ultimaAtualizacaoImagem: '',
                tag: TagModel.init(),
              ),
              abrirScanner: abrirScanner,
              onSubmit: (arvore) async {
                try {
                  final localizacaoAtual = await _requestLocationIfAndroid(context);

                  if (localizacaoAtual == null) {
                    CustomSnackBar.show(
                      context,
                      icon: Icons.error,
                      message: "Não foi possível obter a localização atual.",
                      backgroundColor: theme.colorScheme.errorContainer,
                    );
                    return;
                  }

                  final arvoreComLocalizacao = arvore.copyWith(
                    localizacao: localizacaoAtual.toString(),
                  );

                  final tagVerificada = await arvoreVm.verificarTag(
                    tagArvore.text,
                  );
                  if (tagVerificada == false) {
                    CustomSnackBar.show(
                      context,
                      backgroundColor: theme.colorScheme.onError,
                      message:
                          "Não foi possível cadastrar árvore: ${arvoreVm.erro}",
                      icon: Icons.error,
                    );
                    return;
                  }

                  final arvoreId = await arvoreVm.cadastrarArvore(
                    arvoreComLocalizacao,
                  );

                  if (arvoreId == null) {
                    CustomSnackBar.show(
                      context,
                      backgroundColor: theme.colorScheme.onError,
                      message:
                          "Não foi possível cadastrar árvore: ${arvoreVm.erro}",
                      icon: Icons.error,
                    );
                    return;
                  }

                  final novaArvore = await arvoreVm.getArvoreById(arvoreId);
                  arvoreVm.arvores.insert(0, novaArvore!);

                  if (_base64Image != null && _base64Image!.isNotEmpty) {
                    final res = await arvoreVm.enviarImagem(
                      _base64Image!,
                      arvoreId,
                    );

                    if (res == null || arvoreVm.erro != null) {
                      CustomSnackBar.show(
                        context,
                        backgroundColor: theme.colorScheme.error,
                        message:
                            arvoreVm.erro ??
                            "Erro inesperado ao enviar imagem.",
                        icon: Icons.error,
                      );
                      return;
                    }
                  }

                  CustomSnackBar.show(
                    context,
                    message: "Árvore cadastrada com sucesso! 🌱",
                    icon: Icons.check_circle,
                  );

                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.of(context).pop();
                  });
                } catch (e) {
                  CustomSnackBar.show(
                    context,
                    backgroundColor: theme.colorScheme.onError,
                    icon: Icons.error_outline,
                    message: "Erro ao obter localização ou enviar dados: $e",
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
