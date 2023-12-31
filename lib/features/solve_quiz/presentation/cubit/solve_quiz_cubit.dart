import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/api.dart';
import 'package:capstone_project/core/domain/entity/quiz_no_answers.dart';
import 'package:flutter/material.dart';
import '../../../../core/data/local_storage.dart';
import '../../../../core/domain/entity/quiz.dart';
import '../../../../core/domain/entity/quiz_report.dart';

part 'solve_quiz_state.dart';

class SolveQuizCubit extends Cubit<SolveQuizState> {
  SolveQuizCubit() : super(const SolveQuizInitial());

  Future<void> getQuizForSolving(int quizId) async {
    emit(const SolveQuizLoading());
    try {
      String access = await Storage.getAccess();
      QuizNoAnswers? quizNoAnswers =
          await API.getQuizWithoutAnswers(quizId, access);
      emit(SolveQuizLoaded(quizNoAnswers: quizNoAnswers));
    } catch (e) {
      emit(SolveQuizError(message: e.toString()));
    }
  }

  Future<void> sendAnswers(Map<int, Set<int>> answers, int quizId) async {
    emit(SolveQuizSendAnswers());

    try {
      String access = await Storage.getAccess();
      QuizReport quizReport = await API.getQuizReport(quizId, answers, access);
      Quiz quiz = await API.getQuizWithAnswers(quizId, access);

      emit(SolveQuizShowResults(quizReport: quizReport, quiz: quiz));
    } catch (e) {
      emit(SolveQuizError(message: e.toString()));
    }
  }
}
