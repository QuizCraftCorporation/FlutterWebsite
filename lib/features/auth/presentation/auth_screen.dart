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
    return BlocConsumer<MainAuthCubit, MainAuthState>(
      listener: (context, state) {
        if (state is MainAuthIn){
          AutoRouter.of(context).navigateNamed('/crafter');
        }
      },
      builder: (context, state) {
        // TODO: Check - is it good solution or not. Maybe good ¯\_(ツ)_/¯
        BlocProvider.of<MainAuthCubit>(context).checkAuth();

        return BlocProvider<AuthCubit>(
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
                const Body(),
              ],
            ),
          ),
          create: (BuildContext context) => AuthCubit(),
        );
      },
    );
  }
}
