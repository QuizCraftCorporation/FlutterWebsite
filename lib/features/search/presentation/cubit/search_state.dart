part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchResult extends SearchState {
  final List<QuizPreview> quizzes;
  SearchResult({required this.quizzes});
}

class SearchError extends SearchState {
  final String message;
  SearchError({required this.message});
}
