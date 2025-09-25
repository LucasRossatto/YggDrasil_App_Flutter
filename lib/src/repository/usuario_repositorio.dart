import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/services/api_service.dart';

class UsuarioResponse {
  final UsuarioModel usuario;
  final WalletModel wallet;
  final int qtdeTagsTotal;

  UsuarioResponse({
    required this.usuario,
    required this.wallet,
    required this.qtdeTagsTotal,
  });

  factory UsuarioResponse.fromJson(Map<String, dynamic> json) {
    return UsuarioResponse(
      usuario: UsuarioModel.fromJson(json['usuario']),
      wallet: WalletModel.fromJson(json['walllet']),
      qtdeTagsTotal: json['qtdeTagsTotal'] ?? 0,
    );
  }
}

class UsuarioRepositorio {
  final ApiService _api = ApiService();

  Future<UsuarioModel> cadastrarUsuario(
    String nome,
    String email,
    String senha,
  ) async {
    final data = await _api.post("/CadastrarUsuario", {
      "nome": nome,
      "email": email,
      "senha": senha,
    });
    return UsuarioModel.fromJson(data);
  }

  Future<int?> login(String email, String senha) async {
    final encodedEmail = Uri.encodeComponent(email);
    final encodedSenha = Uri.encodeComponent(senha);
    final data = await _api.get("/GetLogin/$encodedEmail,$encodedSenha");
    if (data['success'] == 1) {
      return data['idUsuario'] as int;
    }
    return null;
  }

   Future<UsuarioResponse> getInformacoesUsuario(String id) async {
    final encodedId = Uri.encodeComponent(id);
    final data = await _api.get("/GetInformacoesBase/$encodedId");
    return UsuarioResponse.fromJson(data);
  }
}
