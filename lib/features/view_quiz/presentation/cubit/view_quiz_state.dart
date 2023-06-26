part of 'view_quiz_cubit.dart';

@immutable
abstract class ViewQuizState {
  const ViewQuizState();
}

class ViewQuizInitial extends ViewQuizState {
  const ViewQuizInitial();
}

class ViewQuizLoading extends ViewQuizState {
  final int quizId;
  const ViewQuizLoading({required this.quizId});
}

class ViewQuizLoaded extends ViewQuizState {
  final Quiz quiz;
  const ViewQuizLoaded({required this.quiz});
}

class ViewQuizError extends ViewQuizState {
  final String message;
  const ViewQuizError({required this.message});
}
