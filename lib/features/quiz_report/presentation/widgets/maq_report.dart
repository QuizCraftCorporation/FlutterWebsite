import 'package:capstone_project/core/domain/entity/multiple_answer_question.dart';
import 'package:flutter/material.dart';

class MAQReport extends StatelessWidget {
  const MAQReport(
      {Key? key,
      required this.maq,
      required this.number,
      required this.chosenOptions,
      required this.score})
      : super(key: key);

  final MultipleAnswerQuestion maq;
  final Set<int> chosenOptions;
  final double score;
  final int number;

  @override
  Widget build(BuildContext context) {
    List<Widget> text = [];
    if (score == 1.0) {
      text.add(
        Container(
          alignment: Alignment.topCenter,
          child: const SelectableText(
            'Your answer is correct',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
              fontSize: 21,
            ),
          ),
        ),
      );
    } else {
      text.add(
        Container(
          alignment: Alignment.topCenter,
          child: const SelectableText(
            'You made a mistake',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
              color: Colors.red
            ),
          ),
        ),
      );
      chosenOptions.add(-1);
    }
    text.add(
      const SizedBox(
        height: 10,
      ),
    );
    text.add(
      SelectableText(
        'Q$number. ${maq.questionText}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21,
        ),
      ),
    );
    text.add(
      const SizedBox(
        height: 10,
      ),
    );
    for (int i = 0; i < maq.options.length; i++) {
      Color textColor = Colors.black;
      // print('Cur: ${maq.options[i].text}, true: ${maq.trueAnswer}');
      if (maq.options[i].text.compareTo(maq.trueAnswer) == 0) {
        textColor = Colors.green;
      }
      if (maq.options[i].id == chosenOptions.first && score == 0) {
        textColor = Colors.red;
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
      margin: const EdgeInsets.only(
        top: 40,
        left: 35,
      ),
      width: MediaQuery.of(context).size.width / 2,
      // height: 150,
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 25, left: 30),
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