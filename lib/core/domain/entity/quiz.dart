import 'package:capstone_project/core/domain/entity/question.dart';
import 'dart:convert';

class Quiz {
  const Quiz({required this.title, required this.description, required this.questions});

  final String title;
  final String description;
  final List<Question> questions;

  static Quiz fromJson(jsonString){
    Map<String, dynamic> quiz = jsonDecode(jsonString);
    
  }

  Map<String, dynamic> toJson(){

  }
}