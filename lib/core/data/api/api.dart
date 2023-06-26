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
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjg3ODYxNzE1LCJpYXQiOjE2ODc3NzUzMTUsImp0aSI6IjU3OTI2NzAxMWFkNjRkYjY5Y2I3OTQ3ZmI2NjUxYjU4IiwidXNlcl9pZCI6Mn0.gDxR-ztbo0TJAZkgmbCTcigDLsZx23JOKBEF_XyMi07Ko8OhE3Oxe1qeQo57pX5T__mCM3gGG-PWyDJo9ZrKsrI_ZxHmY0nCtueE6u_SzYmjkJF5LwEvjtxT73cy9_8_2wZJNKMVu7Sq6qNnd-l3dXnZ10WwEgii0ZG4j1QWXn9oyQfqs4KessEIQV2kCn-_3a_h5CahYcEIKUwCtYv9D4UZq7YFDbLEABXwTS2Mjjkwys7PhkKX5GrULcYLKAZxoX6pAGGzBiHr4Reqs84pGIEsLQfEd8x_HkYWLACqZ6_uZ0bKF5NzsdVsz1MpHO6xTeX4M-mUs8mEvJrnt_t60O7SPv5eE4FUKL50MP1cP5I5FQfSnFySaRUop7X3EPXZyESLeSw1ljJDsuLz7ku8LetJc2ZIzttkmyJmY6SmM8ToKUyV9WrfvrmqiLQdx_ZfB8XUzVLLCSWqZZgWoDLc150Vd7h1pDsNeFIOllElmKYnGx8i5xR7-W_hSqqkiFk0-KNBtrBWiIZo95wMvOK53Y9mV6WXpC9yyD5crTnXtHpbJl6XdQS1L7DynZXWPp6EHULKSV9C0N609xcB8eHTQD8XiTlh52UWnmHx9pxthfS-d5a1anWeUlgmpTGfuqBCKozqM2LDD8bNtfQ18UAyjZfVWXEAn5b-MzWoWBM4RtE';

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
