import 'package:capstone_project/core/domain/entity/multiple_answer_question.dart';
import 'package:capstone_project/core/domain/entity/question.dart';

class Quiz {
  const Quiz(
      {required this.id,
      required this.title,
      required this.description,
      required this.questions,
      required this.private});

  final int id;
  final String title;
  final String description;
  final List<Question> questions;
  final bool private;

  factory Quiz.fromJson(json) {
    //   Map<String, dynamic> quiz = jsonDecode(jsonString);
    List<dynamic> questionsRaw = json['questions']
        .map((data) => MultipleAnswerQuestion.fromJson(data))
        .toList();

    List<Question> questions = [];
    for (int i = 0; i < questionsRaw.length; i++) {
      questions.add(questionsRaw[i] as Question);
    }

    return Quiz(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      questions: questions,
      private: json['private'],
    );
  }

// Map<String, dynamic> toJson(){
//
// }
}
