import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/domain/entity/quiz.dart';

part 'create_quiz_state.dart';

class CreateQuizCubit extends Cubit<CreateQuizState> {
  CreateQuizCubit() : super(const CreateQuizInitial());

  Future<void> quizRequest(String title/*, File file*/, {String description = '', rawText = ''}) async {
    try{
      emit(const CreateQuizLoading());

      await Future.delayed(const Duration(seconds: 5));
      // TODO: Convert data to JSON. Do request for quiz creation
      final Quiz quiz = Quiz(title: title, description: description, questions: []);

      emit(CreateQuizLoaded(quiz));
    } on Exception {
      emit(const CreateQuizError('Всё хуйня, давай по новой'));
    }
  }
}
