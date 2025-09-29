import 'package:yggdrasil_app/src/models/arvore_model.dart';
import 'package:yggdrasil_app/src/services/api_service.dart';

class ArvoreRepositorio {
  final ApiService _api = ApiService();

  /// Cadastra uma nova árvore
  Future<ArvoreModel> cadastrarArvore(ArvoreModel arvore) async {
    final data = await _api.post("/CadastrarArvore", arvore.toJson());
    return ArvoreModel.fromJson(data);
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

  Future<ArvoreModel?> getArvoreByIdQrCode(String qr_code) async {
    final encodedId = Uri.encodeComponent(qr_code.toString());
    final data = await _api.get("/GetPerfilArvorePorQrCode/$encodedId");
    return ArvoreModel.fromJson(data);
  }
}
