import 'package:capstone_project/core/domain/entity/quiz.dart';
import 'package:capstone_project/core/domain/entity/quiz_report.dart';
import 'package:capstone_project/features/quiz_report/presentation/cubit/quiz_report_cubit.dart';
import 'package:capstone_project/features/quiz_report/presentation/widgets/maq_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entity/multiple_answer_question.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.quiz, required this.quizReport});

  final Quiz quiz;
  final QuizReport quizReport;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizReportCubit, QuizReportState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Widget> questions = [];
        for (int i = 0; i < quiz.questions.length; i++) {
          if (quiz.questions[i] is MultipleAnswerQuestion) {
            Set<int> chosen = {};
            double score = 0;
            if (quizReport.chosenOptionIds[quiz.questions[i].id] != null) {
              chosen = quizReport.chosenOptionIds[quiz.questions[i].id]!;
              score = quizReport.scores[quiz.questions[i].id]!;
            }
            questions.add(MAQReport(
              maq: quiz.questions[i] as MultipleAnswerQuestion,
              number: i + 1,
              chosenOptions: chosen,
              score: score,
            ));
          } else {
            // TODO: Show other types of questions
            questions.add(Container());
          }
        }
        return SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 35,
                  ),
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 4,
                  ),
                  child: SelectableText(
                    quiz.title,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: questions,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}