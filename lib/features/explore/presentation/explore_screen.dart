import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/domain/main_auth_cubit/main_auth_cubit.dart';
import 'package:capstone_project/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/appbar/main_appbar.dart';
import '../../../core/presentation/drawer/main_drawer.dart';
import 'widgets/body.dart';

@RoutePage()
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainAuthCubit, MainAuthState>(
      listener: (context, state) {
        // if (state is MainAuthOut) {
        //   AutoRouter.of(context).replaceNamed('/login');
        // }
      },
      builder: (context, state) {
        BlocProvider.of<MainAuthCubit>(context).checkAuth();
        // if (state is! MainAuthIn) {
        //   return Container();
        // }
        return BlocProvider<ExploreCubit>(
          child: Scaffold(
            appBar: MainAppBar(
              title: 'Explore',
              searchCallback: (String searchQuery) {
                AutoRouter.of(context).navigateNamed('/search/$searchQuery');
              },
            ),
            drawer: const MainDrawer(),
            body: Body(login: state is MainAuthIn),
          ),
          create: (BuildContext context) => ExploreCubit(),
        );
      },
    );
  }
}
