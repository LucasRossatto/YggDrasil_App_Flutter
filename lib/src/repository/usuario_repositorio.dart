import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/services/api_service.dart';
import 'package:yggdrasil_app/src/storage/user_storage.dart';

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
  final UserStorage _storage = UserStorage();

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
      await _storage.saveUserId(data['idUsuario']);
      return data['idUsuario'] as int;
    }
    return null;
  }

  Future<UsuarioResponse> getInformacoesUsuario(String id) async {
    final encodedId = Uri.encodeComponent(id);
    final data = await _api.get("/GetInformacoesBase/$encodedId");
    final response = UsuarioResponse.fromJson(data);

    await _storage.saveUsuario(response.usuario);
    await _storage.saveWallet(response.wallet);

    return response;
  }

  // Recupera do storage local
  Future<UsuarioResponse?> getUsuarioLocal() async {
    final usuario = await _storage.getUsuario();
    final wallet = await _storage.getWallet();

    if (usuario != null && wallet != null) {
      return UsuarioResponse(
        usuario: usuario,
        wallet: wallet,
        qtdeTagsTotal: 0,
      );
    }
    return null;
  }

  Future<void> logout() async {
    await _storage.clearAll();
  }
}
