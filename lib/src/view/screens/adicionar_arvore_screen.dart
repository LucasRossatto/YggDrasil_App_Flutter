import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/models/arvore_model.dart';
import 'package:yggdrasil_app/src/models/tag_model.dart';
import 'package:yggdrasil_app/src/shared/widgets/custom_snackbar.dart';
import 'package:yggdrasil_app/src/shared/widgets/gradient_appbar.dart';
import 'package:yggdrasil_app/src/view/widgets/adicionar_arvore_form.dart';
import 'package:yggdrasil_app/src/shared/widgets/camera_button_wrapper.dart';
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
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    tagArvore = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _localizacaoFormatada();
    });
  }

  @override
  void dispose() {
    tagArvore.dispose();
    super.dispose();
  }

  Future<bool> _hasLocationPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) return false;
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Obtém a localização formatada (lat, long)
  Future<String?> _localizacaoFormatada() async {
    setState(() => _isLoadingLocation = true);

    final position = await _requestLocation(context);

    setState(() => _isLoadingLocation = false);

    if (position != null) {
      final formatted = '${position.latitude}, ${position.longitude}';
      debugPrint('Localização: $formatted');
      return formatted;
    } else {
      CustomSnackBar.show(
        context,
        profile: "error",
        message: "Não foi possível obter a localização atual.",
      );
      return null;
    }
  }

  /// Solicita e obtém a posição atual com fallback e tratamento completo
  Future<Position?> _requestLocation(BuildContext context) async {
    try {
      // Verifica permissão
      final hasPermission = await _hasLocationPermission();
      if (!hasPermission) {
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

        LocationPermission permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          CustomSnackBar.show(
            context,
            profile: "error",
            message: "Permissão de localização negada.",
          );
          return null;
        }
      }

      // 🧭 Obtém última posição conhecida como fallback
      final lastKnown = await Geolocator.getLastKnownPosition();

      // 🔄 Tenta obter a localização atual com timeout
      final currentPosition = await Geolocator.getCurrentPosition(
         locationSettings: LocationSettings(accuracy: LocationAccuracy.high)
      ).timeout(const Duration(seconds: 10));

      return currentPosition;
    } on TimeoutException {
      CustomSnackBar.show(
        context,
        profile: "error",
        message: "Tempo limite ao buscar localização. Verifique o GPS.",
      );
      return await Geolocator.getLastKnownPosition();
    } on LocationServiceDisabledException {
      CustomSnackBar.show(
        context,
        profile: "error",
        message: "Serviço de localização desativado.",
      );
      return null;
    } on PermissionDeniedException {
      CustomSnackBar.show(
        context,
        profile: "error",
        message: "Permissão de localização negada.",
      );
      return null;
    } catch (e) {
      debugPrint('Erro ao obter localização: $e');
      CustomSnackBar.show(
        context,
        profile: "error",
        message: "Erro ao obter localização: $e",
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      appBar: GradientAppBar(title: "Adicionar Árvore"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔄 Loader de feedback de localização
              if (_isLoadingLocation)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      LinearProgressIndicator(),
                      SizedBox(height: 8),
                      Text("Obtendo localização atual..."),
                    ],
                  ),
                ),

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
                    final localizacaoAtual = await _localizacaoFormatada();

                    final arvoreComLocalizacao = arvore.copyWith(
                      localizacao: localizacaoAtual ?? '',
                    );

                    final tagVerificada = await arvoreVm.verificarTag(
                      tagArvore.text,
                    );
                    if (tagVerificada == false) {
                      CustomSnackBar.show(
                        context,
                        profile: "error",
                        message:
                            "Não foi possível cadastrar árvore: ${arvoreVm.erro}",
                      );
                      return;
                    }

                    final arvoreId = await arvoreVm.cadastrarArvore(
                      arvoreComLocalizacao,
                    );

                    if (arvoreId == null) {
                      CustomSnackBar.show(
                        context,
                        profile: "error",
                        message:
                            "Não foi possível cadastrar árvore: ${arvoreVm.erro}",
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
                          profile: "error",
                          message:
                              arvoreVm.erro ??
                              "Erro inesperado ao enviar imagem.",
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
                      profile: "error",
                      message: "Erro ao obter localização ou enviar dados: $e",
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
