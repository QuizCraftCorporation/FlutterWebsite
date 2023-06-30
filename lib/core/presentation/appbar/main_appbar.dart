import 'package:flutter/material.dart';

import '../../styles/theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // title: const Text(
      //   'QuizCraft AI',
      // ),
      // titleTextStyle: const TextStyle(
      //   color: Color.fromRGBO(0, 0, 33, 1.0),
      //   fontSize: 28,
      //   fontFamily: 'Literata',
      //   fontWeight: FontWeight.w900,
      // ),
      title: Image.asset('assets/logo_image/logo.png', scale: 4.5,),
      backgroundColor: AppTheme.appbarBackgroundColor,
      shadowColor: Colors.black,
      actions: [
        // Container(alignment: Alignment.center, child: Text(title),),
        // SizedBox(width: MediaQuery.of(context).size.width / 2,),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
