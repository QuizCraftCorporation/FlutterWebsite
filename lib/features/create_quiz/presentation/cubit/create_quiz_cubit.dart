import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/api/api.dart';
import '../../../../core/domain/entity/quiz.dart';

part 'create_quiz_state.dart';

class CreateQuizCubit extends Cubit<CreateQuizState> {
  CreateQuizCubit() : super(const CreateQuizInitial());

  Future<void> quizRequest(String title, String description, String rawText, List<File> files) async {
    emit(const CreateQuizLoading());

    Quiz? quiz = await API.createQuiz(title, description, rawText, files);

    if (quiz != null){
      emit(CreateQuizLoaded(quiz.id));
    } else{
      emit(CreateQuizError());
    }
  }

  void goToView(int quizId){
    emit(CreateQuizGoToView(quizId));
  }

  void goToSolving(int quizId){
    emit(CreateQuizGoToSolving(quizId));
  }
}
