import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/domain/main_auth_cubit/main_auth_cubit.dart';
import 'package:capstone_project/features/my_quizzes/presentation/cubit/my_quizzes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/appbar/main_appbar.dart';
import '../../../core/presentation/drawer/main_drawer.dart';
import 'widgets/body.dart';

@RoutePage()
class MyQuizzesScreen extends StatelessWidget {
  const MyQuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool first = true;
    return BlocConsumer<MainAuthCubit, MainAuthState>(
      listener: (context, state) {
        if (state is MainAuthOut) {
          AutoRouter.of(context).navigateNamed('/login');
        }
      },
      builder: (context, state) {
        if (first) {
          first = false;
          BlocProvider.of<MainAuthCubit>(context).checkAuth();
        }
        if (state is! MainAuthIn) {
          return Container();
        }
        return BlocProvider<MyQuizzesCubit>(
          child: Scaffold(
            appBar: MainAppBar(
              title: 'Quiz',
              searchCallback: (String searchQuery) {
                AutoRouter.of(context).navigateNamed('/search/$searchQuery');
              },
            ),
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
                Body(),
              ],
            ),
          ),
          create: (BuildContext context) => MyQuizzesCubit(),
        );
      },
    );
  }
}
