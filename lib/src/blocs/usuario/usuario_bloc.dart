import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yggdrasil_app/src/blocs/usuario/usuario_event.dart';
import 'package:yggdrasil_app/src/blocs/usuario/usuario_state.dart';
import 'package:yggdrasil_app/src/repository/usuario_repositorio.dart';
import '../../models/wallet_model.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  final UsuarioRepositorio repository;

  UsuarioBloc(this.repository) : super(UsuarioInitial()) {
    on<LoadUsuario>(_onLoadUsuario);
    on<UpdateUsuario>(_onUpdateUsuario);
  }

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

  Future<void> _onUpdateUsuario(
    UpdateUsuario event,
    Emitter<UsuarioState> emit,
  ) async {
    emit(UsuarioLoading());
    try {
      // Supondo que você tenha um método para atualizar no repo
      final updatedUsuario = await repository.cadastrarUsuario(
        event.usuario.nome,
        event.usuario.email,
        '',
      ); // senha se necessário
      // Você pode manter a wallet do estado anterior
      WalletModel currentWallet;

      if (state is UsuarioLoaded) {
        currentWallet = (state as UsuarioLoaded).wallet;
      } else {
        currentWallet = WalletModel.int();
      }
      if (state is UsuarioLoaded) {
        currentWallet = (state as UsuarioLoaded).wallet;
      }
      emit(
        UsuarioLoaded(
          usuario: updatedUsuario,
          wallet: currentWallet,
          qtdeTagsTotal: (state is UsuarioLoaded)
              ? (state as UsuarioLoaded).qtdeTagsTotal
              : 0,
        ),
      );
    } catch (e) {
      emit(UsuarioError(e.toString()));
    }
  }
}
