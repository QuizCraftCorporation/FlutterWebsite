import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/presentation/drawer/cubit/main_drawer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocProvider<MainDrawerCubit>(
        create: (context) => MainDrawerCubit(),
        child: BlocConsumer<MainDrawerCubit, MainDrawerState>(
          listener: (context, state) {
            if (state is MainDrawerToCreateQuizState) {
              AutoRouter.of(context).pushNamed('/crafter');
            } else if (state is MainDrawerToMyQuizzesState) {
              AutoRouter.of(context).pushNamed('/my_quizzes');
            } else if (state is MainDrawerToExploreState) {
              AutoRouter.of(context).pushNamed('/explore');
            } else if (state is MainDrawerToAllQuizzesState) {
              AutoRouter.of(context).pushNamed('/all_quizzes');
            } else if (state is MainDrawerToHelpState) {
              AutoRouter.of(context).pushNamed('/');
            }
          },
          builder: (context, state) {
            return ListView(
              // mainAxisSize: MainAxisSize.max,
              children: [
                // const SizedBox(height: kToolbarHeight,),
                ListTile(
                  leading: const Icon(Icons.add_rounded, color: Colors.blue),
                  title: const Text('Generate Quiz', style: TextStyle(fontSize: 20)),
                  contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                  onTap: () {
                    BlocProvider.of<MainDrawerCubit>(context).goToCreateQuiz();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.folder_copy, color: Colors.blue),
                  title: const Text('My Quizzes', style: TextStyle(fontSize: 20)),
                  contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                  onTap: () {
                    BlocProvider.of<MainDrawerCubit>(context).goToMyQuizzes();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.explore, color: Colors.blue),
                  title: const Text('Explore', style: TextStyle(fontSize: 20)),
                  contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                  onTap: () {
                    BlocProvider.of<MainDrawerCubit>(context).goToExplore();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.list, color: Colors.blue),
                  title: const Text('All Quizzes', style: TextStyle(fontSize: 20)),
                  contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                  onTap: () {
                    BlocProvider.of<MainDrawerCubit>(context).goToAllQuizzes();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline_rounded, color: Colors.blue),
                  title: const Text('Help', style: TextStyle(fontSize: 20)),
                  contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
                  onTap: () {
                    BlocProvider.of<MainDrawerCubit>(context).goToHelp();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
