import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/api.dart';
import 'package:capstone_project/core/data/local_storage.dart';
import 'package:meta/meta.dart';

part 'main_app_bar_state.dart';

class MainAppBarCubit extends Cubit<MainAppBarState> {
  MainAppBarCubit() : super(MainAppBarInitial());

  Future<void> logout() async {
    String refresh = (await Storage.getRefresh())!;
    String access = (await Storage.getAccess())!;
    API.logout(refresh, access);
    emit(MainAppBarLogout());
  }
}
