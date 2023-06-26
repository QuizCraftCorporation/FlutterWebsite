import 'package:capstone_project/core/domain/entity/multiple_answer_question.dart';
import 'package:capstone_project/core/presentation/loading/loading.dart';
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
          return const Loading(text: 'Loading',);
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
        }
        return Container();
      },
    );
  }
}
