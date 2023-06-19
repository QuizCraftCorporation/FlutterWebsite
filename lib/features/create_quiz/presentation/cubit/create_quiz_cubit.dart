import 'dart:convert';
import 'dart:html';
import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/domain/entity/multiple_answer_question.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../../core/domain/entity/quiz.dart';

part 'create_quiz_state.dart';

class CreateQuizCubit extends Cubit<CreateQuizState> {
  CreateQuizCubit() : super(const CreateQuizInitial());

  Future<void> quizRequest(String title/*, File file*/, {String description = '', String rawText = ''}) async {
    emit(const CreateQuizLoading());

    try{

      // await Future.delayed(const Duration(seconds: 2));
      // TODO: Convert data to JSON. Do request for quiz creation
      const baseUrl = '127.0.0.1:8000/api/quiz';

      // File file = File(utf8.encode(rawText), 'Hitler.txt');
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/create'));
      request.files.add(await http.MultipartFile.fromBytes(
        'file',
        utf8.encode(rawText),
        filename: 'Hitler.txt',
      ));
      request.fields['quiz_name'] = title;
      request.fields['source_name'] = title;
      final response = await request.send();
      String body = await response.stream.bytesToString();
      body = jsonDecode(body);

      // final response = await http.post(
      //   Uri.parse('$baseUrl/create_quiz'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json',
      //   },
      //   body: jsonEncode(<String, String>{
      //     // 'access': '',
      //     'quiz_name': title,
      //     // 'description': description,
      //     'source_name': title,
      //   }),
      // );

      if (response.statusCode != 201){
        throw Exception('Cannot create quiz');
      }

      Quiz quiz = Quiz.fromJson(jsonDecode(body));

      emit(CreateQuizLoaded(quiz));
    } on Exception {

      /// Monkey patch
      final Quiz quiz = Quiz(title: title, description: description, questions: [
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Da', questionText: 'В жопу дашь?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Net', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Ya gay', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Da', questionText: 'В жопу дашь?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Net', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Ya gay', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Da', questionText: 'В жопу дашь?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Net', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Ya gay', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Da', questionText: 'В жопу дашь?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Net', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Ya gay', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Da', questionText: 'В жопу дашь?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Net', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
        MultipleAnswerQuestion(answers: ['Da', 'Net', 'Ya gay'], trueAnswer: 'Ya gay', questionText: 'В жопу дашь? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a? a?'),
      ]);
      emit(CreateQuizLoaded(quiz));

      // TODO: Delete code from above with predefined quiz. Here must be error handler
      // emit(const CreateQuizError('Всё хуйня, давай по новой'));
    }
  }
}
