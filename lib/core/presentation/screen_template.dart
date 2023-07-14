import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'appbar/main_appbar.dart';
import 'drawer/main_drawer.dart';

class ScreenTemplate extends StatelessWidget {
  const ScreenTemplate({super.key, required this.body, required this.title});

  final Widget body;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Quiz',
        searchCallback: (String searchQuery) {
          AutoRouter.of(context).pushNamed('/search/$searchQuery');
        },
      ),
      drawer: const MainDrawer(),
      body: body,
    );
  }
}
