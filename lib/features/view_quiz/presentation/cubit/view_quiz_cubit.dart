import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../core/data/api.dart';
import '../../../../core/data/local_storage.dart';
import '../../../../core/domain/entity/quiz.dart';

part 'view_quiz_state.dart';

class ViewQuizCubit extends Cubit<ViewQuizState> {
  ViewQuizCubit() : super(const ViewQuizInitial());

  Future<void> loadQuiz(int quizId) async {
    emit(ViewQuizLoading(quizId: quizId));

    String access = '';

    try {
      access = await Storage.getAccess();
      Quiz quiz = await API.getQuizWithAnswers(quizId, access);
      emit(ViewQuizLoaded(quiz: quiz));
    } catch (e) {
      try {
        Quiz quiz = await API.getQuizWithAnswers(quizId, null);
        emit(ViewQuizLoaded(quiz: quiz));
      } catch (e2) {
        emit(ViewQuizError(message: 'SolveQuizCubit. sendAnswers. Error: ${e2.toString()}'));
      }
    }
  }
}
