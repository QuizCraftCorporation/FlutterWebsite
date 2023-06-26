import 'package:capstone_project/core/domain/entity/question.dart';
import 'multiple_answer_question_no_answer.dart';

class QuizNoAnswers {
  const QuizNoAnswers(
      {required this.id,
        required this.title,
        required this.description,
        required this.questions});

  final int id;
  final String title;
  final String description;
  final List<Question> questions;

  factory QuizNoAnswers.fromJson(json) {
    List<dynamic> questionsRaw = json['questions']
        .map((data) => MultipleAnswerQuestionNoAnswer.fromJson(data))
        .toList();

    List<Question> questions = [];
    for (int i = 0; i < questionsRaw.length; i++){
      questions.add(questionsRaw[i] as Question);
    }

    return QuizNoAnswers(
      id: json['id'],
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
