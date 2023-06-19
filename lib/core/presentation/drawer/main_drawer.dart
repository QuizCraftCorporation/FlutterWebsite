import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // mainAxisSize: MainAxisSize.max,
      children: [
        // const SizedBox(height: kToolbarHeight,),
        ListTile(
          leading: Icon(Icons.add_rounded),
          title: Text('Generate Quiz'),
          contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.folder_copy),
          title: Text('My Quizes'),
          contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.help_outline_rounded),
          title: Text('Help'),
          contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
          onTap: () {},
        ),
      ],
    );
  }
}