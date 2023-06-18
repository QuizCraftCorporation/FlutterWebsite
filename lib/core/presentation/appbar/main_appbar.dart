import 'package:flutter/material.dart';

import '../../styles/theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MainAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('QuizCraft AI',),
      titleTextStyle: const TextStyle(color: Color.fromRGBO(
          0, 0, 33, 1.0), fontSize: 28, fontWeight: FontWeight.w900),
      backgroundColor: AppTheme.appbarBackgroundColor,
      actions: [
        // Container(alignment: Alignment.center, child: Text(title),),
        // SizedBox(width: MediaQuery.of(context).size.width / 2,),
        IconButton(onPressed: (){}, icon: Icon(Icons.notifications),),
        IconButton(onPressed: (){}, icon: Icon(Icons.person),),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
