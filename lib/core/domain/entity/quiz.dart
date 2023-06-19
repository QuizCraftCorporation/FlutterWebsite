import 'package:capstone_project/core/domain/entity/multiple_answer_question.dart';
import 'package:capstone_project/core/domain/entity/question.dart';
import 'dart:convert';

class Quiz {
  const Quiz(
      {required this.title,
      required this.description,
      required this.questions});

  final String title;
  final String description;
  final List<Question> questions;

  factory Quiz.fromJson(json) {
  //   Map<String, dynamic> quiz = jsonDecode(jsonString);
    List<Question> questions = json['questions'].map((data) => MultipleAnswerQuestion.fromJson(jsonDecode(data))).toList();

    return Quiz(
      title: json['title'],
      // description: json['description'],
      description: 'privet',
      questions: questions,
    );
  }

  // Map<String, dynamic> toJson(){
  //
  // }
}
