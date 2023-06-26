part of 'solve_quiz_cubit.dart';

@immutable
abstract class SolveQuizState {
  const SolveQuizState();
}

class SolveQuizInitial extends SolveQuizState {
  const SolveQuizInitial();
}

class SolveQuizLoading extends SolveQuizState {
  const SolveQuizLoading();
}

class SolveQuizLoaded extends SolveQuizState {
  final QuizNoAnswers quizNoAnswers;

  const SolveQuizLoaded({required this.quizNoAnswers});
}

class SolveQuizPrepareAnswers extends SolveQuizState {}

class SolveQuizSendAnswers extends SolveQuizState {
  /// For sending answers, waiting for statistic
}

class SolveQuizShowResults extends SolveQuizState {
  final QuizReport quizReport;
  final Quiz quiz;

  const SolveQuizShowResults({required this.quizReport, required this.quiz});

  /// Navigate to the grade page (but now just show result on the same page)
}

class SolveQuizError extends SolveQuizState {
  final String message;

  const SolveQuizError({required this.message});
}
