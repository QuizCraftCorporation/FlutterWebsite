part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthLogin extends AuthState {}

class AuthLoginProcess extends AuthState {
  final String username;
  final String password;

  const AuthLoginProcess(this.username, this.password);
}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {}

class AuthRegister extends AuthState {}

class AuthRegisterProcess extends AuthState {
  final String username;
  final String password;
  final String firstName;
  final String lastName;

  const AuthRegisterProcess(
      {required this.username,
      required this.password,
      required this.firstName,
      required this.lastName});
}

class AuthRegisterSuccess extends AuthState {}

class AuthRegisterError extends AuthState {
  final String message;

  const AuthRegisterError({required this.message});
}
