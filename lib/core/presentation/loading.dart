import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 2,
        left: MediaQuery.of(context).size.width / 2,
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
