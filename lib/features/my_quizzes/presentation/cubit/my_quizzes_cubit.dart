import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/api.dart';
import 'package:capstone_project/core/data/local_storage.dart';
import 'package:flutter/material.dart';
import '../../../../core/domain/entity/quiz_preview.dart';

part 'my_quizzes_state.dart';

class MyQuizzesCubit extends Cubit<MyQuizzesState> {
  MyQuizzesCubit() : super(MyQuizzesInitial());

  Future<void> getMyQuizzes() async {
    emit(MyQuizzesLoading());
    try {
      String access = (await Storage.getAccess());
      List<QuizPreview> quizzes = await API.getMyQuizzes(access);
      emit(MyQuizzesList(quizzes: quizzes));
    } catch (e) {
      emit(MyQuizzesError(message: e.toString(), ));
    }
  }

  Future<void> search(String search) async {
    emit(MyQuizzesSearch(search: search));
  }
}
