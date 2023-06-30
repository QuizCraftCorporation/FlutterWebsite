import 'package:flutter/material.dart';

class TextFieldCircular extends StatelessWidget {
  const TextFieldCircular(
      {super.key,
      required this.controller,
      required this.lines,
      required this.hint, this.password=false});

  final TextEditingController controller;
  final int lines;
  final String hint;
  final bool password;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
        ),
        maxLines: lines,
        minLines: lines,
        obscureText: password,
      ),
    );
  }
}
