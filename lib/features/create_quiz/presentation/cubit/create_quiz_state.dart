part of 'create_quiz_cubit.dart';

@immutable
abstract class CreateQuizState {
  const CreateQuizState();
}

class CreateQuizInitial extends CreateQuizState {
  const CreateQuizInitial();
}

class CreateQuizLoading extends CreateQuizState {
  const CreateQuizLoading();
}

class CreateQuizLoaded extends CreateQuizState {
  final Quiz quiz;
  const CreateQuizLoaded(this.quiz);

}

class CreateQuizError extends CreateQuizState {
  final String message;
  const CreateQuizError(this.message);
}