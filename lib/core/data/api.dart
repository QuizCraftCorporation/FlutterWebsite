import 'dart:convert';
import 'dart:io';
import '../domain/entity/quiz.dart';
import 'package:http/http.dart' as http;
import '../domain/entity/quiz_no_answers.dart';
import '../domain/entity/quiz_report.dart';
import '../domain/entity/solved_quiz.dart';

class API {
  static const baseUrl = 'http://10.90.138.70:8000/api';

  static Future<List<String>?> login(String username, String password) async {
    try {
      Uri uri = Uri.parse('$baseUrl/auth/login/');
      final response = await http.post(
        uri,
        headers: {
          // 'Content-Type': 'multipart/form-data',
        },
        body: {
          'username': username,
          'password': password,
        }
      );
      // print('login. Body: ${response.body}');
      print('login. Status Code: ${response.statusCode}');
      List<String> tokens = [jsonDecode(response.body)['refresh'], jsonDecode(response.body)['access']];
      return tokens;
    } catch (e) {
      print('login. Error: $e');
    }
    return null;
  }

  static Future<String?> refresh(String refresh, String access) async {
    try {
      Uri uri = Uri.parse('$baseUrl/auth/refresh/');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $access',
        },
        body: {
          'refresh': refresh,
        }
      );
      print('refresh. Status Code: ${response.statusCode}');
      return jsonDecode(response.body)['access'];
    } catch (e) {
      print('refresh. Error: $e');
    }
    return null;
  }

  static Future<List<String>?> register(String username, String password, String firstName, String lastName) async {
    try {
      Uri uri = Uri.parse('$baseUrl/auth/register/');
      final response = await http.post(
        uri,
        body: {
          'username': username,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
        },
      );
      print('register. Status Code: ${response.statusCode}');
      List<String> tokens = [jsonDecode(response.body)['refresh'], jsonDecode(response.body)['access']];
      return tokens;
    } catch (e) {
      print('register. Error: $e');
    }
    return null;
  }

  static Future<void> logout(String refresh, String access) async {
    try {
      Uri uri = Uri.parse('$baseUrl/auth/logout/');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $access',
        },
        body: {
          'refresh': refresh,
        }
      );
      print('logout. Status Code: ${response.statusCode}');
      return;
    } catch (e) {
      print('logout. Error: $e');
    }
  }

  // TODO: wait for implementation
  static Future<void> logoutAll(String refresh, String access) async {
    try {
      Uri uri = Uri.parse('$baseUrl/auth/logout/');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $access',
        },
        body: {
          'refresh': refresh,
        }
      );
      print('logout. Status Code: ${response.statusCode}');
      return;
    } catch (e) {
      print('logout. Error: $e');
    }
  }

  static Future<void> userMe(String refresh, String access) async {
    try {
      Uri uri = Uri.parse('$baseUrl/auth/logout/');
      final response = await http.get(
        uri,
        headers: {
          'refresh': refresh,
          'Authorization': 'Bearer $access',
        },
      );
      print('logout. Status Code: ${response.statusCode}');
      return;
    } catch (e) {
      print('logout. Error: $e');
    }
  }

  static Future<Quiz?> createQuiz(String title, String description,
      String rawText, List<File> files, String access) async {
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
      request.headers['Authorization'] = 'Bearer $access';
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

  static Future<QuizNoAnswers?> getQuizWithoutAnswers(int quizId, String access) async {
    try {
      Uri uri = Uri.parse('$baseUrl/quiz/$quizId/');
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $access',
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
      int quizId, Map<int, Set<int>> answers, String access) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/quiz/attempt/'),
        headers: {
          'Authorization': 'Bearer $access',
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

  static Future<Quiz?> getQuizWithAnswers(int quizId, String access) async {
    try {
      Uri uri = Uri.parse('$baseUrl/quiz/answers/$quizId/');
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $access',
        },
      );
      print('getQuizWithAnswers. Status code: ${response.statusCode}');
      Quiz quiz = Quiz.fromJson(jsonDecode(response.body));
      return quiz;
    } catch (e) {
      print('getQuizWithAnswers. Error: $e');
    }
    return null;
  }
}
