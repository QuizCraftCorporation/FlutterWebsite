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

  // factory Quiz.fromJson(json) {
  // //   Map<String, dynamic> quiz = jsonDecode(jsonString);
  //   List<Question> q = [];
  //   List<int> questions = json['questions'].map((data) => int.parse(data)).toList();
  //   for (int i = 0; i < questions.length; i++){
  //
  //     q.add(
  //
  //     );
  //   }
  //   return Quiz(
  //     title: json['title'],
  //     description: json['description'],
  //     questions: q,
  //   );
  // }

  // Map<String, dynamic> toJson(){
  //
  // }
}
