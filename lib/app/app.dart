import 'package:capstone_project/core/domain/main_auth_cubit/main_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/domain/app_router.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainAuthCubit>(
      create: (context) => MainAuthCubit(),
      child: MaterialApp.router(
        title: 'QuizCraft',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
