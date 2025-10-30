import 'package:YggDrasil/src/models/usuario_model.dart';
import 'package:YggDrasil/src/models/wallet_model.dart';

abstract class UsuarioState {}

class UsuarioInitial extends UsuarioState {}

class UsuarioLoading extends UsuarioState {}

class UsuarioLoaded extends UsuarioState {
  final UsuarioModel usuario;
  final WalletModel wallet;
  final int qtdeTagsTotal;

  UsuarioLoaded({
    required this.usuario,
    required this.wallet,
    required this.qtdeTagsTotal,
  });
}

class UsuarioError extends UsuarioState {
  final String message;
  UsuarioError(this.message);
}
