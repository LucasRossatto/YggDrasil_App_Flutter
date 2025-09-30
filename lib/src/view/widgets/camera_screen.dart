import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  bool _isCameraReady = false;

  @override
  void initState() {
    super.initState();
    if (widget.cameras != null && widget.cameras!.isNotEmpty) {
      _initCamera(widget.cameras![0]);
    }
  }

  Future<void> _initCamera(CameraDescription cameraDescription) async {
    _cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _cameraController.initialize();
      if (!mounted) return;
      setState(() => _isCameraReady = true);
    } on CameraException catch (e) {
      debugPrint("Erro ao inicializar câmera: $e");
    }
  }

  Future<void> _takePicture() async {
    if (!_cameraController.value.isInitialized ||
        _cameraController.value.isTakingPicture) {
      return;
    }

    try {
      XFile picture = await _cameraController.takePicture();

      // Lê bytes diretamente
      final bytes = await picture.readAsBytes();

      // Converte para Base64
      final base64Image = base64Encode(bytes);

      Navigator.of(context).pop(base64Image); // Retorna Base64
    } catch (e) {
      debugPrint("Erro ao tirar foto: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Erro ao tirar foto")));
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _isCameraReady
                ? CameraPreview(_cameraController)
                : Container(
                    color: theme.colorScheme.surface,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.20,
                decoration:  BoxDecoration(
                  color: theme.colorScheme.surface,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 30,
                        icon: Icon(
                          _isRearCameraSelected
                              ? Icons.camera_front_rounded
                              : Icons.camera_rear_outlined,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        onPressed: () {
                          _isRearCameraSelected = !_isRearCameraSelected;
                          setState(() => _isCameraReady = false);
                          _initCamera(
                            widget.cameras![_isRearCameraSelected ? 0 : 1],
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: _takePicture,
                        iconSize: 64,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(Icons.circle_outlined, color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
