import 'dart:convert';
import 'dart:io';
import '../../domain/entity/quiz.dart';
import 'package:http/http.dart' as http;
import '../../domain/entity/quiz_no_answers.dart';
import '../../domain/entity/quiz_report.dart';
import '../../domain/entity/solved_quiz.dart';

class API {
  static const baseUrl = 'http://10.90.138.70:8000/api';

  static const token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjg3NzcyOTAxLCJpYXQiOjE2ODc2ODY1MDEsImp0aSI6ImQwOWU1MDI5YzM1YzQ2OWZhNDZkZTA3N2Y1NDY3N2VmIiwidXNlcl9pZCI6Mn0.h8UCekKVuetXds0fXMpDL2zu0Oku82z1mcbT8rd-6KkitXiCS9jQQnmYKX2uVtC6wj0KGii4mGeitcYKIBAgetJrvKD0EqK4NVfOK2cyeSCjRgUzSSi5FEOKcZLtwDZyF4TwKqb2789GqjPYMp46ufmHtgCTlW3arzDFgu3yOG2Tk1-UGGTMNsbokGUifrV4STmCdh5V_m_Sgb3bcffzb_Fb_FFxi-wpgTmIwPtbI0wchei4_lnWj-cjpQPoyZKw_diBIVbHuQfp1svarwjJJqx5MOpdtRYg3lCrXhWOaMykVVCZBMSXfhBoGjtdn-DVrgx-yNQVcoalBNZYzDCm-rmWax00njafOJMvcVaPYoFFEwHldnCMH6yjVLXkcQv0QsJxSU-O0NZ6jRhGGH8qeRe8mmEG22aw5LoXaWmaNZo4h5QVBr2v9eqR1s2pnxOsxRSbYUYi-TwToGd4ZnxD04Z9o3myLObYa9nGZnAMGfLS0PVkRw1S64f9dWLgUN2TxdD1cDx72s3byq_zxYsIvb47qyhKAQP2SFBg-qDXF59xEVnzRWeRLii5NcgtyKMJKjgFYfrBrEmUel4q6vWYH9tBI2bUxat4aMBDVk-alrW1tbq9T3QTgzcS9w59IDuvsSw1jvjSftNIRrJ6cUv3IurmPoPr4OPTOvFxX_kK0uo';

  static Future<Quiz?> createQuiz(String title, String description,
      String rawText, List<File> files) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/quiz/create/'));
      if (rawText.isNotEmpty) {
        request.files.add(http.MultipartFile.fromString(
          'files',
          rawText,
          filename: 'raw_text.txt',
        ));
      }
      for (int i = 0; i < files.length; i++) {
        request.files.add(http.MultipartFile.fromBytes(
          'files',
          files[i].readAsBytesSync(),
          filename: files[i].path.split('/').last,
        ));
      }
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['quiz_name'] = title;
      request.fields['source_name'] = title;

      final response = await request.send();
      String body = await response.stream.bytesToString();
      print('CreateQuiz. Status Code: ${response.statusCode}');
      Quiz quiz = Quiz.fromJson(jsonDecode(body));
      return quiz;
    } catch (e) {
      print('Create Quiz. Error: $e');
    }
    return null;
  }

  static Future<QuizNoAnswers?> getQuizWithoutAnswers(int quizId) async {
    try {
      Uri uri = Uri.parse('$baseUrl/quiz/$quizId/');
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print('getQuizWithoutAnswers. Status Code: ${response.statusCode}');
      return QuizNoAnswers.fromJson(jsonDecode(response.body));
    } catch (e) {
      print('getQuizWithoutAnswers. Error: $e');
    }
    return null;
  }

  static Future<QuizReport?> getQuizReport(
      int quizId, Map<int, Set<int>> answers) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/quiz/attempt/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          SolvedQuiz(quizId: quizId, optionIds: answers).toJson(),
        ),
      );
      print('getQuizReport. Status Code: ${response.statusCode}');
      QuizReport quizReport = QuizReport.fromJson(jsonDecode(response.body));
      return quizReport;
    } catch (e) {
      print('getQuizReport. Error: $e');
    }
    return null;
  }

  static Future<Quiz?> getQuizWithAnswers(int quizId) async {
    try {
      Uri uri = Uri.parse('$baseUrl/quiz/answers/$quizId/');
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print('getQuizWithAnswers. Status code: ${response.statusCode}');
      Quiz quiz = Quiz.fromJson(jsonDecode(response.body));
      return quiz;
    } catch (e) {
      print('getQuizWithAnswers. Error: e');
    }
    return null;
  }
}
