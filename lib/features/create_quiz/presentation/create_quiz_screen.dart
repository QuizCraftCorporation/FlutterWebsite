import 'package:capstone_project/features/create_quiz/presentation/cubit/create_quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import '../../../core/presentation/appbar/main_appbar.dart';
import '../../../core/presentation/drawer/main_drawer.dart';
import 'widgets/body.dart';

class CreateQuizScreen extends StatelessWidget {
  const CreateQuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: check type of device and run specific design for each
    // bool isDesktop =
    return BlocProvider<CreateQuizCubit>(
      child: Scaffold(
        appBar: MainAppBar(
          title: 'Crafter',
        ),
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
            Body(),
          ],
        ),
        // body: SliderDrawer(
        //   appBar: Container(),
        //   slider: SliderView(),
        //   child: Body(),
        //   sliderOpenSize: 200,
        //   sliderCloseSize: 0,
        // ),
      ),
      create: (BuildContext context) => CreateQuizCubit(),
    );
  }
}

/// Drawer which is good for phones and tablets but not for desktop
// body: SliderDrawer(
//   appBar: Container(),
//   slider: SliderView(),
//   child: Body(),
//   sliderOpenSize: 200,
//   sliderCloseSize: 200,
// ),
