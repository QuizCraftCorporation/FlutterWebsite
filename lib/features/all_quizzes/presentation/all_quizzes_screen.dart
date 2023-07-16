import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/appbar/main_appbar.dart';
import '../../../core/presentation/drawer/main_drawer.dart';
import 'cubit/all_quizzes_cubit.dart';
import 'widgets/body.dart';

@RoutePage()
class AllQuizzesScreen extends StatelessWidget {
  const AllQuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllQuizzesCubit>(
      child: Scaffold(
        appBar: MainAppBar(
          title: 'Quiz',
          searchCallback: (String searchQuery) {
            AutoRouter.of(context).pushNamed('/search/$searchQuery');
          },
        ),
        drawer: const MainDrawer(),
        body: const Body(),
      ),
      create: (BuildContext context) => AllQuizzesCubit(),
    );
  }
}
