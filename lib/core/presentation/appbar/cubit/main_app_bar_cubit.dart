import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_app_bar_state.dart';

class MainAppBarCubit extends Cubit<MainAppBarState> {
  MainAppBarCubit() : super(MainAppBarInitial());
}
