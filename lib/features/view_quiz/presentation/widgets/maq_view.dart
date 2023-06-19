import 'package:capstone_project/core/domain/entity/multiple_answer_question.dart';
import 'package:flutter/material.dart';

class MAQView extends StatelessWidget {
  const MAQView({Key? key, required this.maq}) : super(key: key);

  final MultipleAnswerQuestion maq;

  @override
  Widget build(BuildContext context) {
    List<Widget> text = [
      SelectableText(
        maq.questionText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 19,
          // height: 1.5,
        ),
      )
    ];
    for (int i = 0; i < maq.answers.length; i++) {
      Color textColor = Colors.black;
      if (maq.answers[i] == maq.trueAnswer) {
        textColor = Colors.green;
      }
      text.add(
        SelectableText(
          '\t${i + 1}. ${maq.answers[i]}',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            // height: 1.3,
          ),
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(top: 40),
      // width: MediaQuery.of(context).size.width / 3.5,
      // height: 150,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFE5DFF2),
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
