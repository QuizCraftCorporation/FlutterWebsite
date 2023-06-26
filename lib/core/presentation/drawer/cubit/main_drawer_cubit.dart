import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_drawer_state.dart';

class MainDrawerCubit extends Cubit<MainDrawerState> {
  MainDrawerCubit() : super(MainDrawerInitial());

  void goToCreateQuiz(){
    emit(MainDrawerToCreateQuizState());
  }

  void goToMyQuizzes(){
    emit(MainDrawerToMyQuizzesState());
  }

  void goToSettings(){
    emit(MainDrawerToSettingsState());
  }

  void goToHelp(){
    emit(MainDrawerToHelpState());
  }
}
