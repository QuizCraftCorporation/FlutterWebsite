import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/domain/entity/quiz.dart';
import 'package:capstone_project/core/domain/entity/quiz_report.dart';
import 'package:capstone_project/core/domain/main_auth_cubit/main_auth_cubit.dart';
import 'package:capstone_project/core/presentation/appbar/main_appbar.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/drawer/main_drawer.dart';
import 'widgets/body.dart';
import 'cubit/quiz_report_cubit.dart';

@RoutePage()
class QuizReportScreen extends StatelessWidget {
  const QuizReportScreen(
      {Key? key, required this.quiz, required this.quizReport})
      : super(key: key);

  final Quiz quiz;
  final QuizReport quizReport;

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
        return BlocProvider<QuizReportCubit>(
          create: (context) => QuizReportCubit(),
          child: Scaffold(
            appBar: MainAppBar(
              title: 'Quiz',
              searchCallback: (String searchQuery) {
                AutoRouter.of(context).navigateNamed('/search/$searchQuery');
              },
            ),
            drawer: const MainDrawer(),
            body: Body(
              quiz: quiz,
              quizReport: quizReport,
            ),
          ),
        );
      },
    );
  }
}
