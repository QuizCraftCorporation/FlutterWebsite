import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../core/data/api/api.dart';
import '../../../../core/domain/entity/quiz.dart';

part 'view_quiz_state.dart';

class ViewQuizCubit extends Cubit<ViewQuizState> {
  ViewQuizCubit() : super(const ViewQuizInitial());

  Future<void> loadQuiz(int quizId) async {
    emit(ViewQuizLoading(quizId: quizId));

    Quiz? quiz = await API.getQuizWithAnswers(quizId);

    if (quiz != null) {
      emit(ViewQuizLoaded(quiz: quiz));
    } else{
      emit(ViewQuizError(message: 'SolveQuizCubit. sendAnswers. Error: '));
    }
  }
}
