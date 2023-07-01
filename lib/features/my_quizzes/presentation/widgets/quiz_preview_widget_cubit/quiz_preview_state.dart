part of 'quiz_preview_cubit.dart';

@immutable
abstract class QuizPreviewState {}

class QuizPreviewInitial extends QuizPreviewState {}

class QuizPreviewToViewAnswers extends QuizPreviewState {}

class QuizPreviewToSolver extends QuizPreviewState {}
