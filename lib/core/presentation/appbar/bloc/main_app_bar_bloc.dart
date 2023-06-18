import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_app_bar_event.dart';
part 'main_app_bar_state.dart';

class MainAppBarBloc extends Bloc<MainAppBarEvent, MainAppBarState> {
  MainAppBarBloc() : super(MainAppBarInitial()) {
    on<MainAppBarEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
