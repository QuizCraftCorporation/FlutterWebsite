part of 'all_quizzes_cubit.dart';

@immutable
abstract class AllQuizzesState {}

class AllQuizzesInitial extends AllQuizzesState {}

class AllQuizzesLoading extends AllQuizzesState {}

class AllQuizzesLoaded extends AllQuizzesState {
  final List<QuizPreview> quizzes;

  AllQuizzesLoaded({required this.quizzes});
}

class AllQuizzesError extends AllQuizzesState {
  final String message;

  AllQuizzesError({required this.message});
}


