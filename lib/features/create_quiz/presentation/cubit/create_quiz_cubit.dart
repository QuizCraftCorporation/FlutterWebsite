import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/domain/entity/multiple_answer_question.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../../core/domain/entity/quiz.dart';

part 'create_quiz_state.dart';

class CreateQuizCubit extends Cubit<CreateQuizState> {
  CreateQuizCubit() : super(const CreateQuizInitial());

  Future<void> quizRequest(String title/*, File file*/, {String description = '', rawText = ''}) async {
    emit(const CreateQuizLoading());

    try{

      await Future.delayed(const Duration(seconds: 2));
      // TODO: Convert data to JSON. Do request for quiz creation
      // final baseUrl = '';
      // final response = await http.post(
      //   Uri.parse('$baseUrl/create_quiz'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json',
      //   },
      //   body: jsonEncode(<String, String>{
      //     'access': '',
      //     'title': title,
      //     'description': description,
      //     'raw_text': rawText,
      //   }),
      // );
      //
      // if (response.statusCode != 201){
      //   throw Exception('Cannot create quiz');
      // }
      //
      // jsonDecode(response.body);

      final Quiz quiz = Quiz(title: title, description: description, questions: [
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Da', questionText: 'В жопу дашь?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Net', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Ya gay', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Da', questionText: 'В жопу дашь?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Net', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Ya gay', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Da', questionText: 'В жопу дашь?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Net', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Ya gay', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Da', questionText: 'В жопу дашь?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Net', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Ya gay', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Da', questionText: 'В жопу дашь?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Net', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(['Da', 'Net', 'Ya gay'], 'Ya gay', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
      ]);

      emit(CreateQuizLoaded(quiz));
    } on Exception {
      emit(const CreateQuizError('Всё хуйня, давай по новой'));
    }
  }
}
