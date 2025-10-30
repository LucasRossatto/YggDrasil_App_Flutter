abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String senha;

  LoginRequested({required this.email, required this.senha});
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String userId;
  LoggedIn(this.userId);
}

class LoggedOut extends AuthEvent {}

class DeleteAccountRequested extends AuthEvent {}