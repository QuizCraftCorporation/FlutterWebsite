import 'package:capstone_project/features/create_quiz/presentation/create_quiz_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizCraft',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreateQuizScreen(),
    );
  }
}