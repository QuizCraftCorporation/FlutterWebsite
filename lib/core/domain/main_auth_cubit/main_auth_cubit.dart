import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/api.dart';
import 'package:capstone_project/core/data/local_storage.dart';
import 'package:flutter/material.dart';

part 'main_auth_state.dart';

class MainAuthCubit extends Cubit<MainAuthState> {
  MainAuthCubit() : super(MainAuthUnknown());

  Future<void> checkAuth() async {
    String access;
    String refresh;
    try{
      access = (await Storage.getAccess());
      refresh = (await Storage.getRefresh());
      // emit(MainAuthIn(refresh: refresh, access: access));
    } catch (e) {
      emit(MainAuthOut());
      return;
    }
    try{
      await API.userMe(access);
      if (state is! MainAuthIn) {
        emit(MainAuthIn(refresh: refresh, access: access));
      }
    } catch (e){
      try{
        String newAccess = (await API.refresh(refresh, access));
        emit(MainAuthIn(refresh: refresh, access: newAccess));
      } catch (e){
        emit(MainAuthOut());
      }
    }
  }
}


