part of 'my_quizzes_cubit.dart';

@immutable
abstract class MyQuizzesState {
  const MyQuizzesState();
}

class MyQuizzesInitial extends MyQuizzesState {}

class MyQuizzesLoading extends MyQuizzesState {}

class MyQuizzesList extends MyQuizzesState {
  final List<QuizPreview> quizzes;
  const MyQuizzesList({required this.quizzes});
}

class MyQuizzesError extends MyQuizzesState {
  final String message;
  const MyQuizzesError({required this.message});
}

class MyQuizzesSearch extends MyQuizzesState {
  final String search;
  const MyQuizzesSearch({required this.search});
}
