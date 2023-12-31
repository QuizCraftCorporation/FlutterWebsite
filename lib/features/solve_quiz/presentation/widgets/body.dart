import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/domain/app_router.dart';
import 'package:capstone_project/core/domain/entity/multiple_answer_question_no_answer.dart';
import 'package:capstone_project/core/domain/entity/quiz_no_answers.dart';
import 'package:capstone_project/core/presentation/custom_error_widget.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:capstone_project/features/solve_quiz/presentation/cubit/solve_quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'maq_solve.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.quizId});

  final int quizId;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Map<int, Set<int>> answers = {};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SolveQuizCubit, SolveQuizState>(
      listener: (context, state) {
        if (state is SolveQuizShowResults) {
          AutoRouter.of(context).replace(QuizReportRoute(
              quiz: state.quiz, quizReport: state.quizReport));
        }
      },
      builder: (context, state) {
        if (state is SolveQuizInitial) {
          BlocProvider.of<SolveQuizCubit>(context)
              .getQuizForSolving(widget.quizId);
        }
        if (state is SolveQuizLoading) {
          return const Loading(
            text: 'Loading',
          );
        }
        if (state is SolveQuizLoaded) {
          QuizNoAnswers quizNoAnswers = state.quizNoAnswers;
          List<Widget> questions = [];
          for (int i = 0; i < quizNoAnswers.questions.length; i++) {
            if (quizNoAnswers.questions[i]
                is MultipleAnswerQuestionNoAnswer) {
              // print(quizNoAnswers.questions[i].questionText);
              questions.add(MAQSolve(
                maq: quizNoAnswers.questions[i]
                    as MultipleAnswerQuestionNoAnswer,
                number: i + 1,
                callback: (int qId, int oId, bool newValue) {
                  if (newValue) {
                    answers.putIfAbsent(qId, () => <int>{});
                    answers[qId]?.add(oId);
                  } else {
                    answers[qId]?.remove(oId);
                  }
                },
              ));
            } else {
              // TODO: Show other types of questions
              questions.add(Container());
            }
          }
          questions.add(Container(
            margin: const EdgeInsets.only(top: 35),
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                BlocProvider.of<SolveQuizCubit>(context)
                    .sendAnswers(answers, state.quizNoAnswers.id);
              },
              child: const Text(
                'Submit answers',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ));
          questions.add(const SizedBox(height: 200));
          return SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 35,
                    ),
                    child: SelectableText(
                      'Solving quiz: ${quizNoAnswers.title}',
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: questions,
                  ),
                ],
              ),
            ),
          );
        }
        if (state is SolveQuizSendAnswers) {
          return const Loading(
            text: 'We are checking your answers',
          );
        }
        if (state is SolveQuizError){
          return CustomError(message: state.message);
        }
        return const Loading(text: '');
      },
    );
  }
}
