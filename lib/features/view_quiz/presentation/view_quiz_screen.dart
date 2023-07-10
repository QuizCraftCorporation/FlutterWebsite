import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/domain/main_auth_cubit/main_auth_cubit.dart';
import 'package:capstone_project/core/presentation/appbar/main_appbar.dart';
import 'package:capstone_project/features/view_quiz/presentation/widgets/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/drawer/main_drawer.dart';
import 'cubit/view_quiz_cubit.dart';

@RoutePage()
class ViewQuizScreen extends StatelessWidget {
  const ViewQuizScreen({Key? key, @PathParam('id') required this.quizId})
      : super(key: key);

  final int quizId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainAuthCubit, MainAuthState>(
      listener: (context, state) {
        /// If QuizView will be private screen, then uncomment these sections
        // if (state is MainAuthOut){
        //   AutoRouter.of(context).replaceNamed('/login');
        // }
      },
      builder: (context, state) {
        // BlocProvider.of<MainAuthCubit>(context).checkAuth();

        return BlocProvider<ViewQuizCubit>(
          child: Scaffold(
            appBar: MainAppBar(
              title: 'Quiz',
              searchCallback: (String searchQuery) {
                AutoRouter.of(context).pushNamed('/search/$searchQuery');
              },
            ),
            drawer: const MainDrawer(),
            body: Body(
              quizId: quizId,
            ),
          ),
          create: (BuildContext context) => ViewQuizCubit(),
        );
      },
    );
  }
}
