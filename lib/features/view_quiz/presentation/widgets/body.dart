import 'package:capstone_project/core/domain/entity/multiple_answer_question.dart';
import 'package:capstone_project/features/view_quiz/presentation/widgets/maq_view.dart';
import 'package:flutter/material.dart';
import '../../../../core/domain/entity/quiz.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(left: 35, top: 35),
      child: ListView.builder(
        itemCount: quiz.questions.length + 1,
        itemBuilder: (context, index) {
          if (index == 0){
            return SelectableText(quiz.title, style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,),);
          }
          index -= 1;
          if (quiz.questions[index] is MultipleAnswerQuestion){
            return MAQView(maq: quiz.questions[index] as MultipleAnswerQuestion,);
          }
          return Container();
        },
      ),
    );
  }
}
