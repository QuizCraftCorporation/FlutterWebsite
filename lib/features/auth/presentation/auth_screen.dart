import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/domain/main_auth_cubit/main_auth_cubit.dart';
import '../../../core/presentation/appbar/main_appbar.dart';
import '../../../core/presentation/drawer/main_drawer.dart';
import 'package:auto_route/annotations.dart';
import 'cubit/auth_cubit.dart';
import 'widgets/body.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool first = true;
    return BlocConsumer<MainAuthCubit, MainAuthState>(
      listener: (context, state) {
        if (state is MainAuthIn){
          AutoRouter.of(context).pushNamed('/my_quizzes');
        }
      },
      builder: (context, state) {
        // TODO: Check - is it good solution or not. Maybe good ¯\_(ツ)_/¯
        if (first) {
          first = false;
          BlocProvider.of<MainAuthCubit>(context).checkAuth();
        }
        return BlocProvider<AuthCubit>(
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
          create: (BuildContext context) => AuthCubit(),
        );
      },
    );
  }
}
