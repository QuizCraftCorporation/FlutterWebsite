import 'package:capstone_project/core/domain/entity/option.dart';
import 'package:capstone_project/core/domain/entity/question.dart';

class MultipleAnswerQuestion extends Question {
  MultipleAnswerQuestion(
      {required this.options,
      required this.trueAnswer,
      required super.questionText,
      required super.id});

  final List<Option> options;
  final String trueAnswer;

  factory MultipleAnswerQuestion.fromJson(json) {
    List<dynamic> optionsRaw = json['options'].map((data) => Option.fromJson(data)).toList();
    List<Option> options = [];
    for (int i = 0; i < optionsRaw.length; i++){
      options.add(optionsRaw[i] as Option);
    }
    return MultipleAnswerQuestion(
      id: json['question']['id'],
      options: options,
      trueAnswer: json['answer'].toString(),
      questionText: json['question']['text'].toString(),
    );
  }
}
