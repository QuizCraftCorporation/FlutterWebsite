import 'package:capstone_project/core/domain/entity/option.dart';
import 'package:capstone_project/core/domain/entity/question.dart';

class MultipleAnswerQuestionNoAnswer extends Question {
  MultipleAnswerQuestionNoAnswer(
      {required this.options,
        required super.questionText,
        required super.id});

  final List<Option> options;

  factory MultipleAnswerQuestionNoAnswer.fromJson(json) {
    List<dynamic> optionsRaw = json['options'].map((data) => Option.fromJson(data)).toList();
    List<Option> options = [];
    for (int i = 0; i < optionsRaw.length; i++){
      options.add(optionsRaw[i] as Option);
    }
    return MultipleAnswerQuestionNoAnswer(
      id: json['question']['id'],
      options: options,
      questionText: json['question']['text'].toString(),
    );
  }
}
