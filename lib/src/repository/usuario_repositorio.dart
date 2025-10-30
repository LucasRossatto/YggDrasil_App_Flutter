import 'package:flutter/foundation.dart';
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

class CadastroResponse {
  final int success;
  final String message;

  CadastroResponse({required this.success, required this.message});

  factory CadastroResponse.fromJson(Map<String, dynamic> json) {
    return CadastroResponse(
      success: json['success'] ?? 0,
      message: json['message'] ?? json['Message'] ?? '',
    );
  }

  bool get isSuccess => success == 1;
  bool get isDuplicate => success == 2;
  bool get isError => success == 0;
}

class UsuarioRepositorio {
  final ApiService _api = ApiService();
  final UserStorage _storage = UserStorage();

  Future<CadastroResponse> cadastrarUsuario(
    String nome,
    String email,
    String senha,
  ) async {
    try {
      final response = await _api.post("/CadastrarUsuario", {
        "Nome": nome,
        "Email": email,
        "Senha": senha,
      });

      return CadastroResponse.fromJson(response);
    } catch (e, stack) {
      debugPrint('Erro ao cadastrar usuário: $e\n$stack');
      return CadastroResponse(success: 0, message: "Erro de conexão ou servidor");
    }
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

  Future<CadastroResponse> deletarConta (String id) async {
    final encodedId = Uri.encodeComponent(id);
    final data = await _api.post("/PostRemoverUsuario/$encodedId", {});
    final response = CadastroResponse.fromJson(data);
    return response;
  }
}
