import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/api/api.dart';
import 'package:capstone_project/core/domain/entity/quiz_no_answers.dart';
import 'package:flutter/material.dart';
import '../../../../core/domain/entity/quiz.dart';
import '../../../../core/domain/entity/quiz_report.dart';

part 'solve_quiz_state.dart';

class SolveQuizCubit extends Cubit<SolveQuizState> {
  SolveQuizCubit() : super(const SolveQuizInitial());

  Future<void> getQuizForSolving(int quizId) async {
    emit(const SolveQuizLoading());

    QuizNoAnswers? quizNoAnswers = await API.getQuizWithoutAnswers(quizId);

    if (quizNoAnswers != null) {
      emit(SolveQuizLoaded(quizNoAnswers: quizNoAnswers));
    }
    else {
      emit(SolveQuizError(message: 'SolveQuizCubit. getQuizForSolving. Error: '));
    }
  }

  Future<void> sendAnswers(Map<int, Set<int>> answers, int quizId) async {
    emit(SolveQuizSendAnswers());

    QuizReport? quizReport = await API.getQuizReport(quizId, answers);
    Quiz? quiz = await API.getQuizWithAnswers(quizId);

    if (quizReport != null && quiz != null) {
      emit(SolveQuizShowResults(quizReport: quizReport, quiz: quiz));
    } else{
      emit(SolveQuizError(message: 'SolveQuizCubit. sendAnswers. Error: '));
    }
  }
}
