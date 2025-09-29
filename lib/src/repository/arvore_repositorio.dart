import 'package:flutter/widgets.dart';
import 'package:yggdrasil_app/src/models/arvore_model.dart';
import 'package:yggdrasil_app/src/services/api_service.dart';

class ApiResponse {
  final int success;
  final int idArvore;
  final String message;

  ApiResponse({
    required this.success,
    required this.idArvore,
    required this.message,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'] ?? 0,
      idArvore: json['idArvore'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}

class ArvoreRepositorio {
  final ApiService _api = ApiService();

  /// Cadastra uma nova árvore
  Future<ApiResponse> cadastrarArvore(ArvoreModel arvore) async {
    final data = await _api.post("/CadastrarArvore", arvore.toJson());
    return ApiResponse.fromJson(data);
  }

  /// Busca todas as árvores de um usuário
  Future<List<ArvoreModel>> getArvoresUsuario(int usuarioId) async {
    final encodedId = Uri.encodeComponent(usuarioId.toString());
    final data = await _api.get("/GetArvores/$encodedId");
    return data.entries.map((e) => ArvoreModel.fromJson(e.value)).toList();
  }

  /// Busca uma árvore específica pelo ID
  Future<ArvoreModel?> getArvoreById(int arvoreId) async {
    final encodedId = Uri.encodeComponent(arvoreId.toString());
    final data = await _api.get("/GetPerfilArvore/$encodedId");
    return ArvoreModel.fromJson(data);
  }

  /// Busca uma árvore específica pelo QR Code

  Future<ArvoreModel?> getArvoreByIdQrCode(String qrCode) async {
    final encodedId = Uri.encodeComponent(qrCode.toString());
    final data = await _api.get("/GetPerfilArvorePorQrCode/$encodedId");
    debugPrint(data.toString());
    return ArvoreModel.fromJson(data);
  }
}
