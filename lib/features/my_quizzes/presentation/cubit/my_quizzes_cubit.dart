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
      // print(quizzes);
      emit(MyQuizzesList(quizzes: quizzes));
    } catch (e) {
      // List<QuizPreview> quizzes = [
      //   QuizPreview(quizId: 1, title: 'title1', description: 'description1'),
      //   QuizPreview(quizId: 2, title: 'title2', description: 'description2'),
      //   QuizPreview(quizId: 3, title: 'title3', description: 'description3'),
      //   QuizPreview(quizId: 4, title: 'title4', description: 'description4'),
      //   QuizPreview(quizId: 5, title: 'title5', description: 'description5'),
      //   QuizPreview(quizId: 6, title: 'title6', description: 'description6'),
      //   QuizPreview(quizId: 7, title: 'title7', description: 'description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 '),
      //   QuizPreview(quizId: 1, title: 'title1', description: 'description1'),
      //   QuizPreview(quizId: 2, title: 'title2', description: 'description2'),
      //   QuizPreview(quizId: 3, title: 'title3', description: 'description3'),
      //   QuizPreview(quizId: 4, title: 'title4', description: 'description4'),
      //   QuizPreview(quizId: 5, title: 'title5', description: 'description5'),
      //   QuizPreview(quizId: 6, title: 'title6', description: 'description6'),
      //   QuizPreview(quizId: 7, title: 'title7', description: 'description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 '),
      //   QuizPreview(quizId: 1, title: 'title1', description: 'description1'),
      //   QuizPreview(quizId: 2, title: 'title2', description: 'description2'),
      //   QuizPreview(quizId: 3, title: 'title3', description: 'description3'),
      //   QuizPreview(quizId: 4, title: 'title4', description: 'description4'),
      //   QuizPreview(quizId: 5, title: 'title5', description: 'description5'),
      //   QuizPreview(quizId: 6, title: 'title6', description: 'description6'),
      //   QuizPreview(quizId: 7, title: 'title7', description: 'description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 '),
      //   QuizPreview(quizId: 1, title: 'title1', description: 'description1'),
      //   QuizPreview(quizId: 2, title: 'title2', description: 'description2'),
      //   QuizPreview(quizId: 3, title: 'title3', description: 'description3'),
      //   QuizPreview(quizId: 4, title: 'title4', description: 'description4'),
      //   QuizPreview(quizId: 5, title: 'title5', description: 'description5'),
      //   QuizPreview(quizId: 6, title: 'title6', description: 'description6'),
      //   QuizPreview(quizId: 7, title: 'title7', description: 'description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 '),
      //   QuizPreview(quizId: 1, title: 'title1', description: 'description1'),
      //   QuizPreview(quizId: 2, title: 'title2', description: 'description2'),
      //   QuizPreview(quizId: 3, title: 'title3', description: 'description3'),
      //   QuizPreview(quizId: 4, title: 'title4', description: 'description4'),
      //   QuizPreview(quizId: 5, title: 'title5', description: 'description5'),
      //   QuizPreview(quizId: 6, title: 'title6', description: 'description6'),
      //   QuizPreview(quizId: 7, title: 'title7', description: 'description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 description7 '),
      //
      // ];
      // emit(MyQuizzesList(quizzes: quizzes));
      // TODO: Handle different errors
      print(e);
      emit(MyQuizzesError());
    }
  }
}
