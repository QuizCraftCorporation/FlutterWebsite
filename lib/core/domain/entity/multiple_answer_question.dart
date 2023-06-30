import 'package:capstone_project/core/domain/entity/option.dart';
import 'package:capstone_project/core/domain/entity/question.dart';

class MultipleAnswerQuestion extends Question {
  MultipleAnswerQuestion(
      {required this.options,
      required this.answers,
      required super.questionText,
      required super.id});

  final List<Option> options;
  final List<int> answers;

  factory MultipleAnswerQuestion.fromJson(json) {
    List<dynamic> optionsRaw = json['options'].map((data) => Option.fromJson(data)).toList();
    List<Option> options = [];
    for (int i = 0; i < optionsRaw.length; i++){
      options.add(optionsRaw[i] as Option);
    }
    List<int> answers = [];
    for (int i = 0; i < json['answers'].length; i++){
      answers.add(json['answers'][i] as int);
    }

    return MultipleAnswerQuestion(
      id: json['question']['id'],
      options: options,
      answers: answers,
      questionText: json['question']['text'].toString(),
    );
  }
}
