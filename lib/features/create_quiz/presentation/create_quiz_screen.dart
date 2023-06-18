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
        appBar: const MainAppBar(
          title: 'Crafter',
        ),
        // body: Body(),
        body: SliderDrawer(
          appBar: Container(),
          slider: const SliderView(),
          child: Body(),
          sliderOpenSize: 200,
          sliderCloseSize: 200,
        ),
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
