import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        // bottom: MediaQuery.of(context).size.height / 2,
        // right: MediaQuery.of(context).size.width / 2,
        top: MediaQuery.of(context).size.height / 2 - 50,
        left: MediaQuery.of(context).size.width / 2 - 100,
      ),
      child: Column(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
