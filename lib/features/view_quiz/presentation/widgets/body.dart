import 'package:flutter/material.dart';
import '../../../../core/domain/entity/quiz.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 35, top: 35),
        child: ListView(
          children: [

          ],
        ),
      ),
    );
  }
}
