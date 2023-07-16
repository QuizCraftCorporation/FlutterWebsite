part of 'create_quiz_cubit.dart';

@immutable
abstract class CreateQuizState {
  const CreateQuizState();
}

class CreateQuizInitial extends CreateQuizState {}

class CreateQuizCraftView extends CreateQuizState {}

class CreateQuizLoading extends CreateQuizState {}

class CreateQuizWaiting extends CreateQuizState {
  final int quizId;
  final String message;
  final double progress;

  const CreateQuizWaiting({required this.message, required this.quizId, required this.progress});
}

class CreateQuizLoaded extends CreateQuizState {
  final int quizId;

  const CreateQuizLoaded(this.quizId);
}

class CreateQuizGoToSolving extends CreateQuizState {
  final int quizId;

  const CreateQuizGoToSolving(this.quizId);
}

class CreateQuizGoToView extends CreateQuizState {
  final int quizId;

  const CreateQuizGoToView(this.quizId);
}

class CreateQuizError extends CreateQuizState {
  final String message;

  const CreateQuizError(this.message);
}
