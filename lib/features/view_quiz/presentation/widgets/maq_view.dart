import 'dart:math';
import 'package:capstone_project/core/domain/entity/multiple_answer_question.dart';
import 'package:flutter/material.dart';

class MAQView extends StatelessWidget {
  const MAQView({Key? key, required this.maq, required this.number})
      : super(key: key);

  final MultipleAnswerQuestion maq;
  final int number;

  @override
  Widget build(BuildContext context) {
    List<Widget> text = [
      SelectableText(
        'Q$number. ${maq.questionText}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ];
    for (int i = 0; i < maq.options.length; i++) {
      Color textColor = Colors.black;
      if (maq.answers.contains(maq.options[i].id)) {
        textColor = Colors.green;
      }
      text.add(
        SelectableText(
          '${String.fromCharCode('A'.codeUnits[0] + i)}. ${maq.options[i].text}',
          // textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            height: 1.3,
          ),
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.only(top: 40, right: 10, left: 10),
      width: min(1200, MediaQuery.of(context).size.width),
      // height: 150,
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
      decoration: BoxDecoration(
        color: const Color(0xFFE5DFF2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: text,
      ),
    );
  }
}
