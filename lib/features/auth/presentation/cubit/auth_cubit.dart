import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/api.dart';
import 'package:capstone_project/core/data/local_storage.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthLogin());

  Future<void> login(String username, String password) async {
    emit(AuthLoginProcess(username, password));
    try {
      List<String> tokens = await API.login(username, password);
      await Storage.updateRefresh(tokens[0]);
      await Storage.updateAccess(tokens[1]);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> register(String username, String password, String firstName,
      String lastName) async {
    emit(AuthRegisterProcess(
        username: username,
        password: password,
        firstName: firstName,
        lastName: lastName));
    try {
      await API.register(username, password, firstName, lastName);
      emit(AuthRegisterSuccess());
      emit(AuthLogin());
    } catch (e) {
      emit(AuthRegisterError(message: e.toString()));
    }
  }

  Future<void> regView() async {
    emit(AuthRegister());
  }

  Future<void> loginView() async {
    emit(AuthLogin());
  }
}
