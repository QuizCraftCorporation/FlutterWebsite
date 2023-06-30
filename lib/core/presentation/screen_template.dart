import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'drawer/main_drawer.dart';

class ScreenTemplate extends StatelessWidget {
  const ScreenTemplate({super.key, required this.body, required this.title});

  final Widget body;
  final String title;

  @override
  Widget build(BuildContext context) {
    // if (MediaQuery.of(context).size.height / MediaQuery.of(context).size.width > 1){
    //   return SliderDrawer(
    //     appBar: Container(),
    //     slider: SliderView(), // TODO: recreate widget!!!
    //     sliderOpenSize: 200,
    //     sliderCloseSize: 200,
    //     child: body,
    //   );
    // }
    return Row(
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
        body,
      ],
    );
  }
}

// body: SliderDrawer(
//   appBar: Container(),
//   slider: SliderView(),
//   child: Body(),
//   sliderOpenSize: 200,
//   sliderCloseSize: 200,
// ),