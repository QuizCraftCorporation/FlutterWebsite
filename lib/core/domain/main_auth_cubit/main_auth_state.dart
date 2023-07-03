part of 'main_auth_cubit.dart';

@immutable
abstract class MainAuthState {
  const MainAuthState();
}

class MainAuthIn extends MainAuthState {
  final String access;
  final String refresh;
  const MainAuthIn({required this.refresh, required this.access});
}

class MainAuthOut extends MainAuthState {}

class MainAuthUnknown extends MainAuthState {}
