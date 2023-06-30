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

    String? access = await Storage.getAccess();
    if (access == null){
      // TODO: user don't have auth. Navigate them to auth.
    }
    Quiz? quiz = await API.getQuizWithAnswers(quizId, access!);

    if (quiz != null) {
      emit(ViewQuizLoaded(quiz: quiz));
    } else{
      emit(ViewQuizError(message: 'SolveQuizCubit. sendAnswers. Error: '));
    }
  }
}
