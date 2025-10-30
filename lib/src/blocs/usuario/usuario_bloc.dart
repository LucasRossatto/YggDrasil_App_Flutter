import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:YggDrasil/src/blocs/usuario/usuario_event.dart';
import 'package:YggDrasil/src/blocs/usuario/usuario_state.dart';
import 'package:YggDrasil/src/repository/usuario_repositorio.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  final UsuarioRepositorio repository;

  UsuarioBloc(this.repository) : super(UsuarioInitial()) {
    on<LoadUsuario>(_onLoadUsuario);  }

  Future<void> _onLoadUsuario(
    LoadUsuario event,
    Emitter<UsuarioState> emit,
  ) async {
    emit(UsuarioLoading());
    try {
      final response = await repository.getInformacoesUsuario(event.idUsuario.toString());
      emit(
        UsuarioLoaded(
          usuario: response.usuario,
          wallet: response.wallet,
          qtdeTagsTotal: response.qtdeTagsTotal,
        ),
      );
    } catch (e) {
      emit(UsuarioError(e.toString()));
    }
  }

 
}
