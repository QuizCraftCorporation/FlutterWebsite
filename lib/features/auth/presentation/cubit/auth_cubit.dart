import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/api.dart';
import 'package:capstone_project/core/data/local_storage.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoginProcess(username, password));
    List<String>? tokens = await API.login(username, password);
    if (tokens != null){
      await Storage.updateRefreshToken(tokens[0]);
      await Storage.updateAccessToken(tokens[1]);
      emit(AuthSuccess());
    } else{
      emit(AuthError());
    }
  }
}
