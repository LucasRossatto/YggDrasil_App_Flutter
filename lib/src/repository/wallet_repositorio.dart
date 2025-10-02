import 'package:yggdrasil_app/src/services/api_service.dart';

class ApiResponse {
  final int success;
  final String message;

  ApiResponse({required this.success, required this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}

class DadosTransferencia {
  final String walletSaida;
  final String walletDestino;
  final int quantidade;
  final String tipo;

  DadosTransferencia({
    required this.walletSaida,
    required this.walletDestino,
    required this.quantidade,
    required this.tipo,
  });

  Map<String, dynamic> toJson() {
    return {
      'walletSaida': walletSaida,
      'walletDestino': walletDestino,
      'quantidade': quantidade,
      'tipo': tipo,
    };
  }

  factory DadosTransferencia.fromJson(Map<String, dynamic> json) {
    return DadosTransferencia(
      walletSaida: json['walletSaida'] ?? '',
      walletDestino: json['walletDestino'] ?? '',
      quantidade: json['quantidade'] ?? 0,
      tipo: json['tipo'] ?? '',
    );
  }
}

class WalletRepositorio {
  final ApiService _api = ApiService();

  Future<ApiResponse> validarTransferencia(DadosTransferencia dadosTransferencia) async {
    final response = await _api.post('/ValidarTransferencia',dadosTransferencia.toJson());
    return ApiResponse.fromJson(response);
  }

  Future<ApiResponse> transferir(DadosTransferencia dadosTransferencia) async {
    final response = await _api.post('/Transferir', dadosTransferencia.toJson());
    return ApiResponse.fromJson(response);
  }
}


