import 'dart:convert';
import 'package:capstone_project/core/domain/entity/quiz_preview.dart';
import 'package:file_picker/file_picker.dart';
import '../domain/entity/quiz.dart';
import 'package:http/http.dart' as http;
import '../domain/entity/quiz_no_answers.dart';
import '../domain/entity/quiz_report.dart';
import '../domain/entity/solved_quiz.dart';

class API {
  static const baseUrl = 'http://10.90.138.70:8000/api';

  static Future<List<String>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login/'),
      body: {
        'username': username,
        'password': password,
      },
    );
    print('login. Status Code: ${response.statusCode}');
    List<String> tokens = [
      jsonDecode(response.body)['refresh'],
      jsonDecode(response.body)['access']
    ];
    return tokens;
  }

  static Future<String> refresh(String refresh, String access) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/refresh/'),
      headers: {
        'Authorization': 'Bearer $access',
      },
      body: {
        'refresh': refresh,
      },
    );
    print('refresh. Status Code: ${response.statusCode}');
    return jsonDecode(response.body)['access'];
  }

  static Future<List<String>> register(String username, String password,
      String firstName, String lastName) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register/'),
      body: {
        'username': username,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
      },
    );
    print('register. Status Code: ${response.statusCode}');
    // print(response.body);
    // print(jsonDecode(response.body));
    List<String> data = [
      jsonDecode(response.body)['id'].toString(),
      jsonDecode(response.body)['username'].toString(),
      jsonDecode(response.body)['first_name'].toString(),
      jsonDecode(response.body)['last_name_name'].toString(),
    ];
    return data;
  }

  static Future<void> logout(String refresh, String access) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/logout/'),
      headers: {
        'Authorization': 'Bearer $access',
      },
      body: {
        'refresh': refresh,
      },
    );
    print('logout. Status Code: ${response.statusCode}');
    return;
  }

  static Future<void> logoutAll(String refresh, String access) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/logout_all/'),
      headers: {
        'Authorization': 'Bearer $access',
      },
      body: {
        'refresh': refresh,
      },
    );
    print('logout. Status Code: ${response.statusCode}');
    return;
  }

  static Future<void> userMe(String access) async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/user-me/'),
      headers: {
        'Authorization': 'Bearer $access',
      },
    );
    print('userMe. Status Code: ${response.statusCode}');
    return;
  }

  static Future<int> createQuiz(String title, String description,
      String rawText, List<PlatformFile> files, int numberOfQuestions, bool public, String access) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/quiz/'));
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
        files[i].bytes!,
        filename: files[i].name,
      ));
    }
    request.headers['Authorization'] = 'Bearer $access';
    request.fields['quiz_name'] = title;
    request.fields['source_name'] = title;
    if (numberOfQuestions > 0) {
      request.fields['max_questions'] = numberOfQuestions.toString();
    }
    if (!public) {
      request.fields['private'] = true.toString();
    }
    final response = await request.send();
    String body = await response.stream.bytesToString();
    print('CreateQuiz. Status Code: ${response.statusCode}');
    return jsonDecode(body)['id'];
  }

  static Future<QuizNoAnswers> getQuizWithoutAnswers(
      int quizId, String access) async {
    final response = await http.get(
      Uri.parse('$baseUrl/quiz/$quizId/'),
      headers: {
        'Authorization': 'Bearer $access',
      },
    );
    print('getQuizWithoutAnswers. Status Code: ${response.statusCode}');
    return QuizNoAnswers.fromJson(jsonDecode(response.body));
  }

  static Future<QuizReport> getQuizReport(
      int quizId, Map<int, Set<int>> answers, String access) async {
    final response = await http.post(
      Uri.parse('$baseUrl/quiz/$quizId/attempt/'),
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
  }

  static Future<Quiz> getQuizWithAnswers(int quizId, String access) async {
    final response = await http.get(
      Uri.parse('$baseUrl/quiz/$quizId/?answer=true'),
      headers: {
        'Authorization': 'Bearer $access',
      },
    );
    print('getQuizWithAnswers. Status code: ${response.statusCode}');
    Quiz quiz = Quiz.fromJson(jsonDecode(response.body));
    return quiz;
  }

  static Future<List<QuizPreview>> getMyQuizzes(String access) async {
    final response = await http.get(
      Uri.parse('$baseUrl/quiz/me/'),
      headers: {
        'Authorization': 'Bearer $access',
      },
    );
    print('getMyQuizzes. Status code: ${response.statusCode}');
    // print('getMyQuizzes. Body: ${response.body}');
    List<QuizPreview> quizzes = [];
    List<dynamic> body = jsonDecode(response.body)
        .map((data) => QuizPreview.fromJson(data))
        .toList();
    for (int i = 0; i < body.length; i++){
      quizzes.add(body[i] as QuizPreview);
    }
    return quizzes;
  }

  static Future<List<QuizPreview>> searchQuizzes(String search) async {
    final response = await http.get(
      // TODO: Wait for the true link and method
      Uri.parse('$baseUrl/quiz/search/'),
    );
    print('searchQuizzes. Status code: ${response.statusCode}');
    List<QuizPreview> quizzes = [];
    List<dynamic> body = jsonDecode(response.body)
        .map((data) => QuizPreview.fromJson(data))
        .toList();
    for (int i = 0; i < body.length; i++){
      quizzes.add(body[i] as QuizPreview);
    }
    return quizzes;
  }

  static Future<List<QuizPreview>> getExploreCategory(String category, {String? access}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/quiz/?sort=$category&limit=10'),
    );
    print('getExploreCategory. Category=$category. Status code: ${response.statusCode}');
    List<QuizPreview> quizzes = [];
    List<dynamic> body = jsonDecode(response.body)
        .map((data) => QuizPreview.fromJson(data))
        .toList();
    for (int i = 0; i < body.length; i++){
      quizzes.add(body[i] as QuizPreview);
    }
    return quizzes;
  }

  static Future<List<QuizPreview>> getExploreHistory(String access) async {
    final response = await http.get(
      Uri.parse('$baseUrl/quiz/?sort=last_viewed&limit=10'),
      headers: {
        'Authorization': 'Bearer $access',
      }
    );
    print('getExploreHistory. Status code: ${response.statusCode}');
    List<QuizPreview> quizzes = [];
    List<dynamic> body = jsonDecode(response.body)
        .map((data) => QuizPreview.fromJson(data))
        .toList();
    for (int i = 0; i < body.length; i++){
      quizzes.add(body[i] as QuizPreview);
    }
    return quizzes;
  }
  
  static Future<bool> isCrafterFree(String access) async {
    final response = await http.get(
      Uri.parse('$baseUrl/quiz/check_generation/'),
      headers: {
        'Authorization': 'Bearer $access',
      }
    );
    print('isCrafterFree. Status Code: ${response.statusCode}');
    // TODO: Wait for Gleb's answer
    if (response.statusCode == 200 || jsonDecode(response.body)['detail'] == 'You have no quizzes generating for you.'){
      return true;
    } else{
      return false;
    }
  }
}
