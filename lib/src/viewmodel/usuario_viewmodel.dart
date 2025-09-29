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

  Future<void> cadastrarUsuario(String nome, String email, String senha) async {
    isLoading = true;
    erro = null;
    notifyListeners();
    try {
      usuario = await _repo.cadastrarUsuario(nome, email, senha);
    } catch (e) {
      erro = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<UsuarioResponse?> getInformacoesUsuario(String id) async {
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      final response = await _repo.getInformacoesUsuario(id);

       usuario = response.usuario;
       wallet = response.wallet;
       qtdeTagsTotal = response.qtdeTagsTotal;

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
