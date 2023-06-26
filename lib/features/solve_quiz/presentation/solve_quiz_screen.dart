import 'package:capstone_project/features/solve_quiz/presentation/cubit/solve_quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/appbar/main_appbar.dart';
import '../../../core/presentation/drawer/main_drawer.dart';
import 'package:auto_route/annotations.dart';
import 'widgets/body.dart';

@RoutePage()
class SolveQuizScreen extends StatelessWidget {
  const SolveQuizScreen({super.key, @PathParam('id') required this.quizId});

  final int quizId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SolveQuizCubit>(
      child: Scaffold(
        appBar: const MainAppBar(title: 'Quiz'),
        body: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.02),
              ),
              width: 200,
              child: const MainDrawer(),
            ),
            Body(
              quizId: quizId,
            ),
          ],
        ),
      ),
      create: (BuildContext context) => SolveQuizCubit(),
    );
  }
}
