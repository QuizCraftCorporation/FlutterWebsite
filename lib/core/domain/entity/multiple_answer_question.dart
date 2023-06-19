import 'package:capstone_project/core/domain/entity/question.dart';

class MultipleAnswerQuestion extends Question {
  MultipleAnswerQuestion(
      {required this.answers,
      required this.trueAnswer,
      required super.questionText});

  final List<String> answers;
  final String trueAnswer;

  factory MultipleAnswerQuestion.fromJson(json) {
    List<String> answers = json['options'].map((data) => data['text']).toList();
    return MultipleAnswerQuestion(
      answers: answers,
      trueAnswer: json['answer'],
      questionText: json['question'],
    );
  }
}
