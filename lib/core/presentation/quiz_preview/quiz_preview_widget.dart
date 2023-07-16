import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/domain/entity/quiz_preview.dart';
import 'package:capstone_project/core/presentation/quiz_preview/cubit/quiz_preview_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizPreviewWidget extends StatelessWidget {
  const QuizPreviewWidget({super.key, required this.quizPreview, this.isMine = false});

  final QuizPreview quizPreview;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    Widget? leading;
    if (isMine){
      if (quizPreview.private){
        leading = const Tooltip(message: 'Private', child: Icon(Icons.lock, color: Colors.red,));
      } else {
        leading = const Tooltip(message: 'Public', child: Icon(Icons.public, color: Colors.blue,));
      }
    }
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
      width: min(1200, MediaQuery.of(context).size.width),
      child: BlocProvider<QuizPreviewCubit>(
        create: (context) => QuizPreviewCubit(),
        child: BlocConsumer<QuizPreviewCubit, QuizPreviewState>(
          listener: (context, state) {
            if (state is QuizPreviewToViewAnswers) {
              AutoRouter.of(context)
                  .pushNamed('/quiz/${quizPreview.quizId}/view');
            }
            if (state is QuizPreviewToSolver) {
              AutoRouter.of(context)
                  .pushNamed('/quiz/${quizPreview.quizId}/solve');
            }
          },
          builder: (context, state) {
            return Card(
              child: ListTile(
                visualDensity:
                    const VisualDensity(vertical: VisualDensity.maximumDensity),
                leading: leading,
                trailing: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (quizPreview.ready) ...[
                      TextButton(
                        onPressed: () =>
                            BlocProvider.of<QuizPreviewCubit>(context)
                                .goToViewAnswers(),
                        child: const Text(
                          'View with answers',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            BlocProvider.of<QuizPreviewCubit>(context)
                                .goToSolver(),
                        child: const Text(
                          'Solve',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ] else ...[
                      Text('Quiz is not created yet'),
                      CircularProgressIndicator(),
                    ],
                  ],
                ),
                title: Text(
                  quizPreview.title,
                  style: const TextStyle(
                    fontSize: 28,
                    decoration: TextDecoration.underline,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  quizPreview.description,
                  style: const TextStyle(
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis,
                      color: Color.fromRGBO(51, 51, 51, 0.7)),
                  maxLines: 2,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
