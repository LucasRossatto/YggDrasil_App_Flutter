import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalizacaoService {
  static Future<String?> getCurrentLocation() async {
    try {
      // 1) Verifica se o serviço de localização está ativo
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("Serviço de localização desativado.");
      }

      // 2) Checa permissão com permission_handler
      final status = await Permission.location.status;
      if (status.isDenied) {
        final result = await Permission.location.request();
        if (!result.isGranted) return null; // usuário negou
      } else if (status.isPermanentlyDenied) {
        await openAppSettings(); // abre tela de configurações
        return null;
      }

      // 3) Pega posição atual
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // 4) Retorna como "lat,lng"
      return "${position.latitude},${position.longitude}";
    } catch (e) {
      debugPrint("Erro ao obter localização: $e");
      return null;
    }
  }
}
