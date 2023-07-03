import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/domain/entity/quiz_preview.dart';
import 'package:capstone_project/features/my_quizzes/presentation/widgets/quiz_preview_widget_cubit/quiz_preview_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizPreviewWidget extends StatelessWidget {
  const QuizPreviewWidget({super.key, required this.quizPreview});

  final QuizPreview quizPreview;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizPreviewCubit>(
      create: (context) => QuizPreviewCubit(),
      child: BlocConsumer<QuizPreviewCubit, QuizPreviewState>(
        listener: (context, state) {
          if (state is QuizPreviewToViewAnswers) {
            AutoRouter.of(context)
                .replaceNamed('/quiz/${quizPreview.quizId}/view');
          }
          if (state is QuizPreviewToSolver) {
            AutoRouter.of(context)
                .replaceNamed('/quiz/${quizPreview.quizId}/solve');
          }
        },
        builder: (context, state) {
          return Card(
            child: ListTile(
              visualDensity:
                  VisualDensity(vertical: VisualDensity.maximumDensity),
              trailing: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (quizPreview.ready)...[TextButton(
                      onPressed: () => BlocProvider.of<QuizPreviewCubit>(context)
                          .goToViewAnswers(),
                      child: const Text(
                        'View with answers',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  TextButton(
                    onPressed: () =>
                        BlocProvider.of<QuizPreviewCubit>(context).goToSolver(),
                    child: const Text(
                      'Solve',
                      style: TextStyle(fontSize: 20),
                    ),
                  )] else...[Text('Quiz is not created yet')],
                ],
              ),
              title: Text(
                quizPreview.title,
                style: TextStyle(
                  fontSize: 25,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              titleTextStyle: TextStyle(
                  // TODO: Create textstyle in theme and use them
                  ),
              subtitle: Text(
                quizPreview.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              subtitleTextStyle: TextStyle(
                  // TODO: Create textstyle in theme and use them
                  ),
            ),
          );
        },
      ),
    );
  }
}
