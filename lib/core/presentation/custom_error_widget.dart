import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final String message;

  const CustomError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Something is not right here... $message. Try to refresh the page",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}