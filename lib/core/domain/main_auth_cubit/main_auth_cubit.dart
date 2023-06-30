import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/local_storage.dart';
import 'package:meta/meta.dart';

part 'main_auth_state.dart';

class MainAuthCubit extends Cubit<MainAuthState> {
  MainAuthCubit() : super(MainAuthOut());

  Future<void> checkAuth() async {
    if (await Storage.getAccess() != null){
      emit(MainAuthIn());
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


