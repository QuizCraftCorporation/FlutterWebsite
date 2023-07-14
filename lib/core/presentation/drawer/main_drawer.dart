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
            } else if (state is MainDrawerToHelpState) {

            }
          },
          builder: (context, state) {
            return ListView(
              // mainAxisSize: MainAxisSize.max,
              children: [
                // const SizedBox(height: kToolbarHeight,),
                ListTile(
                  leading: Icon(Icons.add_rounded),
                  title: Text('Generate Quiz'),
                  contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                  onTap: () {
                    BlocProvider.of<MainDrawerCubit>(context).goToCreateQuiz();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.folder_copy),
                  title: Text('My Quizzes'),
                  contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                  onTap: () {
                    BlocProvider.of<MainDrawerCubit>(context).goToMyQuizzes();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.explore),
                  title: Text('Explore'),
                  contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                  onTap: () {
                    BlocProvider.of<MainDrawerCubit>(context).goToExplore();
                  },
                ),
                // ListTile(
                //   leading: Icon(Icons.help_outline_rounded),
                //   title: Text('Help'),
                //   contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
                //   onTap: () {
                //     BlocProvider.of<MainDrawerCubit>(context).goToHelp();
                //   },
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
