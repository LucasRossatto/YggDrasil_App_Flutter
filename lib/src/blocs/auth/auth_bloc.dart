import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_event.dart';
import 'package:yggdrasil_app/src/blocs/auth/auth_state.dart';
import 'package:yggdrasil_app/src/repository/usuario_repositorio.dart';
import 'package:yggdrasil_app/src/storage/user_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UsuarioRepositorio repositorio;
  AuthBloc(this.repositorio) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (userId != null) {
      emit(AuthUnauthenticated());
    } else {
      emit(AuthAuthenticated(userId: userId));
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userId = await repositorio.login(event.email, event.senha);
      if (userId != null) {
        // salvar id do usuário no storage
        await UserStorage().saveUserId(userId);
        emit(AuthAuthenticated(userId: userId.toString()));
      } else {
        emit(AuthError('Email ou senha inválidos'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', event.userId);
    emit(AuthAuthenticated(userId: event.userId));
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    emit(AuthUnauthenticated());
  }
}
