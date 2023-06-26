import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/features/create_quiz/presentation/create_quiz_screen.dart';
import 'package:capstone_project/features/view_quiz/presentation/view_quiz_screen.dart';
import 'package:capstone_project/features/solve_quiz/presentation/solve_quiz_screen.dart';
import 'package:capstone_project/features/quiz_report/presentation/quiz_report_screen.dart';
import 'package:capstone_project/core/domain/entity/quiz.dart';
import 'package:capstone_project/core/domain/entity/quiz_report.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: CreateQuizRoute.page,
          path: '/crafter',
          initial: true,
          title: (context, routeData) => 'Crafter',
        ),
        AutoRoute(
          page: ViewQuizRoute.page,
          path: '/quiz/:id',
          title: (context, routeData) {
            // routeData.
            return 'Quiz: ...';
          },
        ),
        AutoRoute(
          page: SolveQuizRoute.page,
          path: '/quiz/solve/:id',
          title: (context, routeData) {
            return 'Solve Quiz ...';
          },
        ),
        AutoRoute(page: QuizReportRoute.page, path: '/quiz/report'),
      ];
}