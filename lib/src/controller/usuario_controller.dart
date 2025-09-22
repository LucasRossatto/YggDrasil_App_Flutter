import 'package:yggdrasil_app/src/repository/usuario_repositorio.dart';

import '../models/usuario_model.dart';

class UsuarioController {
  final UsuarioRepositorio _repository;

  UsuarioController(this._repository);

  Future<UsuarioModel> cadastrarUsuario(
    String nome,
    String email,
    String senha,
  ) async {
    return await _repository.cadastrarUsuario(nome, email, senha);
  }
}
