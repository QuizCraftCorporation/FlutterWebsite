import 'package:capstone_project/core/domain/entity/question.dart';

class MultipleAnswerQuestion extends Question {
  MultipleAnswerQuestion(this.answers, this.trueAnswer, {required super.questionText});

  final List<String> answers;
  final String trueAnswer;
}