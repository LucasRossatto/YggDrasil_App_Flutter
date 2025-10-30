import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_event.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_state.dart';
import 'package:yggdrasil_app/src/repository/usuario_repositorio.dart';
import 'package:yggdrasil_app/src/services/secure_storage_service.dart';
import 'package:yggdrasil_app/src/storage/user_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UsuarioRepositorio repositorio;
  final SecureStorageService _secureStorage = SecureStorageService();
  AuthBloc(this.repositorio) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<DeleteAccountRequested>(_onDeleteAccountRequested);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    debugPrint('AuthBloc: AppStarted event recebido');
    emit(AuthLoading());
    try {
      final userId = await _secureStorage.getInt('usuario_id');
      debugPrint('AuthBloc: userId do storage: $userId');

      if (userId != null) {
        debugPrint('AuthBloc: usuário encontrado, emitindo AuthAuthenticated');
        emit(AuthAuthenticated(userId: userId.toString()));
      } else {
        debugPrint('AuthBloc: nenhum usuário logado, emitindo AuthUnauthenticated');
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      debugPrint('AuthBloc: erro no AppStarted: $e');
      emit(AuthError('Erro ao verificar login: $e'));
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('AuthBloc: LoginRequested para email: ${event.email}');
    emit(AuthLoading());
    try {
      final userId = await repositorio.login(event.email, event.senha);
      debugPrint('AuthBloc: resposta do login: $userId');

      if (userId != null) {
        await UserStorage().saveUserId(userId);
        debugPrint('AuthBloc: userId salvo no storage: $userId');
        emit(AuthAuthenticated(userId: userId.toString()));
      } else {
        debugPrint('AuthBloc: login falhou, emitindo AuthError');
        emit(AuthError('Email ou senha inválidos'));
      }
    } catch (e) {
      debugPrint('AuthBloc: exceção no login: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    debugPrint('AuthBloc: LoggedIn event recebido para userId: ${event.userId}');
    emit(AuthLoading());
    try {
      await _secureStorage.saveData('usuario_id', event.userId);
      debugPrint('AuthBloc: userId salvo no SharedPreferences: ${event.userId}');
      emit(AuthAuthenticated(userId: event.userId));
    } catch (e) {
      debugPrint('AuthBloc: erro no LoggedIn: $e');
      emit(AuthError('Erro ao logar usuário: $e'));
    }
  }

  Future<void> _onDeleteAccountRequested(
  DeleteAccountRequested event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());

  try {
    final userId = await _secureStorage.getInt('usuario_id');

    if (userId == null) {
      debugPrint('AuthBloc: ID do usuário não encontrado');
      emit(const AuthError('ID de usuário inválido'));
      return;
    }

    await repositorio.deletarConta(userId.toString());
    await UserStorage().clearAll();

    debugPrint('AuthBloc: Conta deletada e dados limpos para userId $userId');

    emit(AuthUnauthenticated());
  } catch (e, stack) {
    debugPrint('Erro ao deletar conta: $e');
    debugPrint(stack.toString());
    emit(AuthError('Erro ao remover conta: ${e.toString()}'));
  }
}


  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    debugPrint('AuthBloc: LoggedOut event recebido');
    emit(AuthLoading());
    try {
      await UserStorage().clearAll();
      debugPrint('AuthBloc: storage limpo, emitindo AuthUnauthenticated');
      emit(AuthUnauthenticated());
    } catch (e) {
      debugPrint('AuthBloc: erro no logout: $e');
      emit(AuthError('Erro ao deslogar usuário: $e'));
    }
  }
}