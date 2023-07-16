import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/domain/entity/quiz_preview.dart';
import 'package:capstone_project/features/explore/presentation/widgets/quiz_preview_card_cubit/quiz_preview_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizPreviewCardWidget extends StatelessWidget {
  const QuizPreviewCardWidget({super.key, required this.quizPreview});

  final size = 280.0;
  final QuizPreview quizPreview;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: size + 30,
      // height: size + 30,
      child: BlocProvider<QuizPreviewCardCubit>(
        create: (context) => QuizPreviewCardCubit(),
        child: BlocConsumer<QuizPreviewCardCubit, QuizPreviewCardState>(
          listener: (context, state) {
            if (state is QuizPreviewCardGoSolve) {
              AutoRouter.of(context)
                  .pushNamed('/quiz/${quizPreview.quizId}/solve');
            }
            if (state is QuizPreviewCardGoView) {
              AutoRouter.of(context)
                  .pushNamed('/quiz/${quizPreview.quizId}/view');
            }
          },
          builder: (context, state) {
            return Container(
              // alignment: Alignment.center,
              width: size,
              height: size,
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(35)),
                color: Color.fromRGBO(225, 225, 225, 1.0),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(101, 101, 101, 1.0),
                      blurRadius: 2,
                      offset: Offset(2, 3))
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black)),
                    ),
                    child: Text(
                      ' ${quizPreview.title}               ',
                      style: const TextStyle(fontSize: 26),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${quizPreview.description}\n\n\n\n\n\n\n\n\n\n\n\n',
                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                    ),
                    maxLines: 8,
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () =>
                              BlocProvider.of<QuizPreviewCardCubit>(context)
                                  .goToView(),
                          child: const Text(
                            'View with answers',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        TextButton(
                          onPressed: () =>
                              BlocProvider.of<QuizPreviewCardCubit>(context)
                                  .goToSolve(),
                          child: const Text(
                            'Solve',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
