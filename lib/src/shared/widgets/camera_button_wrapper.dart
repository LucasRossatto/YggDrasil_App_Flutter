import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:yggdrasil_app/src/view/widgets/camera_screen.dart';

class CameraButtonWrapper extends StatefulWidget {
  final Function(String) onImageCaptured;

  const CameraButtonWrapper({super.key, required this.onImageCaptured});

  @override
  State<CameraButtonWrapper> createState() => _CameraButtonWithPreviewState();
}

class _CameraButtonWithPreviewState extends State<CameraButtonWrapper> {
  List<CameraDescription>? cameras;
  String? _base64Image; // guarda a imagem em Base64

  @override
  void initState() {
    super.initState();
    _initCameras();
  }

  Future<void> _initCameras() async {
    try {
      cameras = await availableCameras();
      setState(() {});
    } catch (e) {
      debugPrint("Erro ao acessar câmeras: $e");
    }
  }

  Future<void> _openCamera() async {
    if (cameras == null || cameras!.isEmpty) {
      debugPrint("Nenhuma câmera encontrada");
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraPage(cameras: cameras)),
    );

    if (result != null && result is String && result.isNotEmpty) {
      setState(() {
        _base64Image = result;
      });
      widget.onImageCaptured(result);
    } else {
      debugPrint("⚠️ Nenhuma imagem recebida da câmera");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        if (_base64Image != null && _base64Image!.isNotEmpty)
          ClipRRect(
            child: Image.memory(
              base64Decode(_base64Image!),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          )
        else
          Container(
            height: 200,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.outline),
              color: theme.colorScheme.secondary,
            ),
            child:  Text(
              "Nenhuma foto encontrada",
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),

        const SizedBox(height: 12),

        // Botão da câmera
        ElevatedButton.icon(
          onPressed: _openCamera,
          icon: const Icon(Icons.camera_alt),
          label: const Text("Tirar foto da árvore"),
        ),
      ],
    );
  }
}
