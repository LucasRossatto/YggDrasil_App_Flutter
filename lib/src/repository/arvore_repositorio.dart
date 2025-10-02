import 'package:flutter/widgets.dart';
import 'package:yggdrasil_app/src/models/arvore_model.dart';
import 'package:yggdrasil_app/src/services/api_service.dart';

class ApiResponse {
  final int success;
  final int idArvore;
  final String tagid;
  final ArvoreModel perfil;
  final String message;

  ApiResponse({
    required this.success,
    required this.idArvore,
    required this.message,
    required this.perfil,
    required this.tagid,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'] ?? 0,
      idArvore: json['idArvore'] ?? 0,
      tagid: json['tagid'] ?? '',
      message: json['message'] ?? '',
      perfil: json['perfil'] != null
          ? ArvoreModel.fromJson(json['perfil'])
          : ArvoreModel(
              id: 0,
              usuarioId: 0,
              tagId: '',
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
            ),
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
  Future<Map<String, dynamic>> getArvoresUsuario(
    int usuarioId, {
    int page = 1,
    int size = 5,
  }) async {
    final response = await _api.getWithQuery(
      "GetArvores/$usuarioId",
      queryParameters: {"page": page.toString(), "size": size.toString()},
    );
    final List<dynamic> arvoresJson = response['arvores'] ?? [];

    return {
      "arvores": arvoresJson
          .map((json) => ArvoreModel.fromJson(json as Map<String, dynamic>))
          .toList(),
      "qtdeTotal": response['qtdeTagsTotal'] ?? 0,
    };
  }

  Future<ApiResponse> verificarTag(String tag) async {
    final encodedTag = Uri.encodeComponent(tag);
    final response = await _api.get('/GetVerificarTag/$encodedTag');
    return ApiResponse.fromJson(response);
  }

  /// Busca uma árvore específica pelo ID
  Future<ArvoreModel?> getArvoreById(int arvoreId) async {
    final encodedId = Uri.encodeComponent(arvoreId.toString());
    final data = await _api.get("/GetPerfilArvore/$encodedId");
    return ArvoreModel.fromJson(data['perfil']);
  }

  /// Busca uma árvore pelo QR Code
  Future<ArvoreModel?> getArvoreByIdQrCode(String qrCode) async {
    final encodedId = Uri.encodeComponent(qrCode.toString());
    final data = await _api.get("/GetPerfilArvorePorQrCode/$encodedId");
    debugPrint(data.toString());
    if (data['success'] == 1 && data['perfil'] != null) {
      return ArvoreModel.fromJson(data["perfil"]);
    }
    return null;
  }

  Future enviarImagem(String image, int id) async {
    final data = await _api.post("/EnviarImagem", {"image": image, "id": id});
    return data;
  }
}
