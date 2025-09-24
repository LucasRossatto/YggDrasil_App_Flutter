import 'package:flutter/material.dart';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/repository/usuario_repositorio.dart';

class UsuarioViewModel extends ChangeNotifier {
  final UsuarioRepositorio _repo = UsuarioRepositorio();

  bool isLoading = false;
  UsuarioModel? usuario;
  String? erro;

  Future<void> login(String email, String senha) async {
    isLoading = true;
    erro = null;
    notifyListeners();

    try {
      usuario = await _repo.login(email, senha);
    } catch (e) {
      erro = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
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
}
