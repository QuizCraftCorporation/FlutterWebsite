import 'package:capstone_project/core/data/local_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/api.dart';

part 'create_quiz_state.dart';

class CreateQuizCubit extends Cubit<CreateQuizState> {
  CreateQuizCubit() : super(CreateQuizInitial());

  Future<void> isFree() async {
    emit(CreateQuizLoading());
    String access = '';
    try {
      access = await Storage.getAccess();
      int quizId = await API.isCrafterFree(access);
      if (quizId == -1) {
        emit(CreateQuizCraftView());
        return;
      }
      var (value, message) = await API.checkProgress(quizId, access);
      if (state is! CreateQuizWaiting) {
        emit(CreateQuizWaiting(
            quizId: quizId,
            message:
                'You have quiz in progress. Please wait unlit their completion.\nStatus: $message',
            progress: value));
      }
    } catch (e) {
      emit(CreateQuizError(e.toString()));
    }
  }

  Future<void> quizRequest(String title, String description, String rawText,
      List<PlatformFile> files, int numberOfQuestions, bool public) async {
    emit(CreateQuizLoading());
    String access = '';
    try {
      access = await Storage.getAccess();
      int quizId = await API.isCrafterFree(access);
      if (quizId != -1) {
        var (value, message) = await API.checkProgress(quizId, access);
        emit(CreateQuizWaiting(
            message:
                'You already have quiz in progress. Please wait unlit their completion.\nStatus: $message',
            quizId: quizId,
            progress: value));
        return;
      }
      quizId = await API.createQuiz(title, description, rawText, files,
          numberOfQuestions, public, access);
      if (state is CreateQuizWaiting) {
        return;
      }
      emit(CreateQuizWaiting(
          quizId: quizId, progress: 0, message: 'Do magic for quiz creation'));
    } catch (e) {
      emit(CreateQuizError(e.toString()));
    }
  }

  Future<void> checkCompletion(int quizId) async {
    // while (true) {
    await Future.delayed(const Duration(seconds: 9, milliseconds: 500));
    String access = '';
    try {
      access = await Storage.getAccess();
      emit(CreateQuizLoading());
      var (value, message) = await API.checkProgress(quizId, access);
      if (message == 'SUCCESS') {
        emit(CreateQuizLoaded(quizId));
        return;
      } else {
        if (state is CreateQuizWaiting) {
          return;
        }
        emit(CreateQuizWaiting(
            message: 'Please wait unlit quiz completion.\nStatus: $message',
            quizId: quizId,
            progress: value));
      }
    } catch (e) {
      emit(CreateQuizError(e.toString()));
      return;
    }
    // }
  }

  void goToView(int quizId) {
    emit(CreateQuizGoToView(quizId));
  }

  void goToSolving(int quizId) {
    emit(CreateQuizGoToSolving(quizId));
  }
}
