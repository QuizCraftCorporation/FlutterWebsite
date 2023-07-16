import 'package:capstone_project/core/presentation/custom_error_widget.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:capstone_project/features/all_quizzes/presentation/cubit/all_quizzes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entity/quiz_preview.dart';
import '../../../../core/presentation/quiz_preview/quiz_preview_widget.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<AllQuizzesCubit, AllQuizzesState>(
          builder: (context, state) {
            if (state is AllQuizzesInitial){
              BlocProvider.of<AllQuizzesCubit>(context).getAllQuizzes();
            } else if (state is AllQuizzesLoading) {
              return const Loading(text: 'Loading all quizzes.');
            } else if (state is AllQuizzesLoaded){
              List<Widget> previews = [];
              for (QuizPreview quizPreview in state.quizzes) {
                previews.add(QuizPreviewWidget(quizPreview: quizPreview));
              }
              if (previews.isEmpty) {
                return Container(
                  margin: const EdgeInsets.only(top: 100),
                  alignment: Alignment.center,
                  child: const Text(
                    "No quizzes on hub..? Then go and generate some",
                    style: TextStyle(fontSize: 25),
                  ),
                );
              }
              return Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: const Text(
                      'All Quizzes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: previews,
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                ],
              );
            } else if (state is AllQuizzesError) {
              return CustomError(message: state.message);
            }
            return const Loading(text: '');
          },
        ),
      ),
    );
  }
}
