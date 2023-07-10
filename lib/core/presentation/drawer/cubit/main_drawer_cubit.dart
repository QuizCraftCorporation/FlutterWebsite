import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'main_drawer_state.dart';

class MainDrawerCubit extends Cubit<MainDrawerState> {
  MainDrawerCubit() : super(MainDrawerInitial());

  void goToCreateQuiz(){
    emit(MainDrawerToCreateQuizState());
  }

  void goToMyQuizzes(){
    emit(MainDrawerToMyQuizzesState());
  }

  void goToExplore(){
    emit(MainDrawerToExploreState());
  }

  void goToHelp(){
    emit(MainDrawerToHelpState());
  }
}
