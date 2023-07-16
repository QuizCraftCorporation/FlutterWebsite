part of 'quiz_report_cubit.dart';

@immutable
abstract class QuizReportState {}

class QuizReportInitial extends QuizReportState {}

class QuizReportError extends QuizReportState {
  final String message;

  QuizReportError({required this.message});
}
