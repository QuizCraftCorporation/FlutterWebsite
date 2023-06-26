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
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjg3ODYzMTc4LCJpYXQiOjE2ODc3NzY3NzgsImp0aSI6IjljNzEyMzJlZWQ1ZjQ0Zjg5M2UzNzVkM2RjYjFjZjRkIiwidXNlcl9pZCI6M30.WHo0EeNMF4fDL29xf7FlyLSu6OIgq9gfzFQ3YTZHLx1WCOS3bnn1-oQUv_HfbU7v9Uy6jUWIBGsspmW1zL-BrQZBDpMf6x7XCVlk_iBFlpTuVX9EExTHAIctLRh9JevaN-wSHkb0lHmOjRhhlsDw9q-Yb0E9jBvAW13E3xtprvOFXkYyAdPAXzQ6NaR0LuFv_BXM0E8dmGchj86Iv4UwMrLXMtJ_0RwG5vXBIDFJyVCQS7U1M6OYtzLrC9Eq7hgg-b_7UZGhaVVCnOuNH4adASh3WMiePU1HFpVB7lzhALFQXRruyMbzycpFTsXfvhf-ER-mCBY8eW5HX0-1BfndBnAeIeYDnvZWnZjrRcBX3OXxbJ4fAa6NTSmIB4uxPpJp1wt1R4rtzjkRfldHKThXJCZgSyprpUR1WwlNPjrd3BTz7f3n9Mg1DkH8W_YojHWOTy7MQKsXK7KfCof5SK0PK03uEJ3zMPM5ufGkbqw__9bDZJ2buD2PinpFoXKretmDFEZlmLrmALBQ8W8IwMubQC78VTbSWcH8lzMeAwqW6GKEq84CmtiG4jKWwQJ1GM6yQHrWYVR-IwSwkwMToa7bdA3hNbxMv1VtFf_WOxe0XN_Sfjl6tA0401kvRW0OtmqwCP0vgqflzfMIaMevq_wTVwyv_2HlLnHCHt5LxHsTZ9Q';

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
