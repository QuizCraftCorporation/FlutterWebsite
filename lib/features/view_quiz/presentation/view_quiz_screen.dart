import 'package:capstone_project/core/domain/entity/quiz.dart';
import 'package:capstone_project/core/presentation/appbar/main_appbar.dart';
import 'package:capstone_project/features/view_quiz/presentation/bloc/view_quiz_bloc.dart';
import 'package:capstone_project/features/view_quiz/presentation/widgets/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '../../../core/presentation/drawer/main_drawer.dart';

class ViewQuizScreen extends StatelessWidget {
  const ViewQuizScreen({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: Scaffold(
        appBar: const MainAppBar(title: 'Quiz'),
        // body: Body(),
        // body: SliderDrawer(
        //   appBar: Container(),
        //   slider: const MainDrawer(),
        //   sliderOpenSize: 200,
        //   sliderCloseSize: 200,
        //   child: Body(quiz: quiz),
        // ),
        body: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.02),
              ),
              width: 200,
              child: MainDrawer(),
            ),
            Body(quiz: quiz,),
          ],
        ),
      ),
      create: (BuildContext context) => ViewQuizBloc(),
    );
  }
}
