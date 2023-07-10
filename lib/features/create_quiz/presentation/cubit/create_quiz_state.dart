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

class CreateQuizWaiting extends CreateQuizState {
  final int quizId;
  const CreateQuizWaiting({required this.quizId});
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

class CreateQuizSendFile extends CreateQuizState {
  final File file;
  const CreateQuizSendFile(this.file);
}
