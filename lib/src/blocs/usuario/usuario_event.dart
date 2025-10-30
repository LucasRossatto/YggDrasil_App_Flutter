import 'package:YggDrasil/src/models/usuario_model.dart';

abstract class UsuarioEvent {}

class LoadUsuario extends UsuarioEvent {
  final String idUsuario;
  LoadUsuario([this.idUsuario = '']);
}

class UpdateUsuario extends UsuarioEvent {
  final UsuarioModel usuario;
  UpdateUsuario(this.usuario);
}
