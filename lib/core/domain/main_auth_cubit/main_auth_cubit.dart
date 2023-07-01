import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/api.dart';
import 'package:capstone_project/core/data/local_storage.dart';
import 'package:meta/meta.dart';

part 'main_auth_state.dart';

class MainAuthCubit extends Cubit<MainAuthState> {
  MainAuthCubit() : super(MainAuthOut());

  Future<void> checkAuth() async {
    if (state is MainAuthIn){
      return;
    }
    if (await Storage.getAccess() != null){
      try{
        String access = (await Storage.getAccess())!;
        await API.userMe(access);
        emit(MainAuthIn());
      } catch (e){
        emit(MainAuthOut());
      }
    } else {
      emit(MainAuthOut());
    }
  }

  Future<void> login() async {
    // TODO: Is it enough?
    emit(MainAuthIn());
  }

  Future<void> logout() async {
    emit(MainAuthOut());
  }
}


