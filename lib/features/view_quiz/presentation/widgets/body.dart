import 'dart:math';
import 'package:capstone_project/core/domain/entity/multiple_answer_question.dart';
import 'package:capstone_project/core/presentation/custom_error_widget.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:capstone_project/features/view_quiz/presentation/cubit/view_quiz_cubit.dart';
import 'package:capstone_project/features/view_quiz/presentation/widgets/maq_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/domain/entity/quiz.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.quizId}) : super(key: key);

  final int quizId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewQuizCubit, ViewQuizState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ViewQuizInitial) {
          final cubit = BlocProvider.of<ViewQuizCubit>(context);
          cubit.loadQuiz(quizId);
        }
        if (state is ViewQuizLoading) {
          return const Loading(
            text: 'Loading',
          );
        }
        if (state is ViewQuizLoaded) {
          Quiz quiz = state.quiz;
          List<Widget> questions = [];
          for (int i = 0; i < quiz.questions.length; i++) {
            if (quiz.questions[i] is MultipleAnswerQuestion) {
              questions.add(MAQView(
                maq: quiz.questions[i] as MultipleAnswerQuestion,
                number: i + 1,
              ));
            } else {
              // TODO: Show other types of questions
              questions.add(Container());
            }
          }
          questions.add(const SizedBox(
            height: 200,
          ));
          return SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 35,
                    ),
                    child: Text(
                      quiz.title,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: min(1200, MediaQuery.of(context).size.width),
                    padding:
                        const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Text(
                      'Description: ${quiz.description}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: questions,
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                ],
              ),
            ),
          );
        }
        if (state is ViewQuizError) {
          return CustomError(message: state.message);
        }
        return const Loading(text: '');
      },
    );
  }
}
