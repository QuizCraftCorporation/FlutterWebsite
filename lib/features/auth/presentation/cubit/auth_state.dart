part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoginProcess extends AuthState {
  final String username;
  final String password;
  const AuthLoginProcess(this.username, this.password);
}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {}
