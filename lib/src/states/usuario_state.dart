import 'package:flutter/foundation.dart';
import '../models/usuario_model.dart';

class UsuarioState extends ChangeNotifier {
  UsuarioModel _usuario = UsuarioModel.init();
  bool _logado = false;

  // Getters
  UsuarioModel get usuario => _usuario;
  bool get logado => _logado;

  // Login ou set manual do usuário
  void setUsuario(UsuarioModel usuario) {
    _usuario = usuario;
    _logado = true;
    notifyListeners();
  }

  // Atualizar campos usando copyWith
  void updateNome(String nome) {
    _usuario = _usuario.copyWith(nome: nome);
    notifyListeners();
  }

  void updateEmail(String email) {
    _usuario = _usuario.copyWith(email: email);
    notifyListeners();
  }

  void updateSenha(String senha) {
    _usuario = _usuario.copyWith(senha: senha);
    notifyListeners();
  }

  // Logout
  void logout() {
    _usuario = UsuarioModel.init();
    _logado = false;
    notifyListeners();
  }
}
