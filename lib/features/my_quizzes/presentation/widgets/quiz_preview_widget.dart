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
            AutoRouter.of(context).navigateNamed('/quiz/${quizPreview.quizId}');
          }
          if (state is QuizPreviewToSolver) {
            AutoRouter.of(context)
                .navigateNamed('/quiz/solve/${quizPreview.quizId}');
          }
        },
        builder: (context, state) {
          return ListTile(
            title: Row(
              children: [
                Text(quizPreview.title),
                const SizedBox(
                  width: 35,
                ),
                TextButton(
                  onPressed: () => BlocProvider.of<QuizPreviewCubit>(context).goToViewAnswers(),
                  child: const Text(
                    'View with answers',
                    // style: TextStyle(fontSize: ),
                  ),
                ),
                const SizedBox(
                  width: 35,
                ),
                TextButton(
                  onPressed: () => BlocProvider.of<QuizPreviewCubit>(context).goToSolver(),
                  child: const Text(
                    'Solve',
                    // style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            titleTextStyle: TextStyle(
                // TODO: Create textstyle in theme and use them
                ),
            subtitle: Text(quizPreview.description),
            subtitleTextStyle: TextStyle(
                // TODO: Create textstyle in theme and use them
                ),
          );
        },
      ),
    );
  }
}
