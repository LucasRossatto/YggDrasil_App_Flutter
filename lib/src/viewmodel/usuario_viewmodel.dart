import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/repository/usuario_repositorio.dart';

class UsuarioViewModel extends ChangeNotifier {
  final UsuarioRepositorio _repo = UsuarioRepositorio();

  bool isLoading = false;
  UsuarioModel? usuario;
  WalletModel? wallet;
  int? qtdeTagsTotal;
  String? erro;

  Future<int?> login(String email, String senha) async {
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      final usuario = await _repo.login(email, senha);
      return usuario;
    } catch (e) {
      erro = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<CadastroResponse> cadastrarUsuario(
    String nome,
    String email,
    String senha,
  ) async {
    isLoading = true;
    notifyListeners();

    final resposta = await _repo.cadastrarUsuario(nome, email, senha);
    if (resposta.isSuccess) {
      debugPrint("Usuário cadastrado com sucesso!");
    } else if (resposta.isDuplicate) {
      debugPrint("Usuário já existe!");
    } else {
      debugPrint("Erro no cadastro: ${resposta.message}");
    }
    isLoading = false;
    notifyListeners();
    return resposta;
  }

  Future<CadastroResponse?> getInformacoesUsuario(String id) async {
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      final response = await _repo.deletarConta(id);
      return response;
    } catch (e) {
      erro = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }
}
