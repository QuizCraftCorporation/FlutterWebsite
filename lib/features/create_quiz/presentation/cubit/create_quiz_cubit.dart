import 'package:capstone_project/core/data/local_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/api.dart';

part 'create_quiz_state.dart';

class CreateQuizCubit extends Cubit<CreateQuizState> {
  CreateQuizCubit() : super(const CreateQuizInitial());

  Future<void> quizRequest(String title, String description, String rawText, List<PlatformFile> files, int numberOfQuestions, bool public) async {
    emit(const CreateQuizLoading());
    String access = '';
    int quizId = 1;
    try {
      access = await Storage.getAccess();
      quizId = await API.createQuiz(
          title,
          description,
          rawText,
          files,
          numberOfQuestions,
          public,
          access);
      emit(CreateQuizWaiting(quizId: quizId));
    } catch(e){
      emit(CreateQuizError(e.toString()));
      return;
    }
    int time = 0;
    while (true) {
      try {
        await API.getQuizWithoutAnswers(quizId, access);
        emit(CreateQuizLoaded(quizId));
        break;
      } catch (e) {
        await Future.delayed(const Duration(seconds: 15));
        time += 16;
        if (time >= 240){
          break;
        }
      }
    }
    // TODO: Error handler
  }

  void goToView(int quizId){
    emit(CreateQuizGoToView(quizId));
  }

  void goToSolving(int quizId){
    emit(CreateQuizGoToSolving(quizId));
  }
}
