import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/domain/main_auth_cubit/main_auth_cubit.dart';
import 'package:capstone_project/features/solve_quiz/presentation/cubit/solve_quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/appbar/main_appbar.dart';
import '../../../core/presentation/drawer/main_drawer.dart';
import '../../../core/presentation/loading.dart';
import 'widgets/body.dart';

@RoutePage()
class SolveQuizScreen extends StatelessWidget {
  const SolveQuizScreen({super.key, @PathParam('id') required this.quizId});

  final int quizId;

  @override
  Widget build(BuildContext context) {
    bool first = true;

    return BlocConsumer<MainAuthCubit, MainAuthState>(
      listener: (context, state) {
        if (state is MainAuthOut) {
          AutoRouter.of(context).replaceNamed('/login');
        }
      },
      builder: (context, state) {
        // if (first) {
        //   first = false;
          BlocProvider.of<MainAuthCubit>(context).checkAuth();
        // }
        if (state is! MainAuthIn) {
          return const Loading(text: '');
        }
        return BlocProvider<SolveQuizCubit>(
          child: Scaffold(
            appBar: MainAppBar(
              title: 'Quiz',
              searchCallback: (String searchQuery) {
                AutoRouter.of(context).pushNamed('/search/$searchQuery');
              },
            ),
            drawer: const MainDrawer(),
            body: Body(
              quizId: quizId,
            ),
          ),
          create: (BuildContext context) => SolveQuizCubit(),
        );
      },
    );
  }
}
