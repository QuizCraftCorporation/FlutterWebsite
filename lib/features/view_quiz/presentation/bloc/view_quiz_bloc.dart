import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_quiz_event.dart';
part 'view_quiz_state.dart';

class ViewQuizBloc extends Bloc<ViewQuizEvent, ViewQuizState> {
  ViewQuizBloc() : super(ViewQuizInitial()) {
    on<ViewQuizEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
