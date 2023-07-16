import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(
        top: 150,
      ),
      child: Column(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
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
