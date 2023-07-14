import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCircular extends StatelessWidget {
  const TextFieldCircular({
    super.key,
    required this.controller,
    required this.lines,
    required this.hint,
    this.password = false,
    this.formatters = const [],
    this.textInputType,
    this.maxLength,
    this.labelText = '',
  });

  final TextEditingController controller;
  final int lines;
  final String hint;
  final bool password;
  final List<TextInputFormatter> formatters;
  final TextInputType? textInputType;
  final int? maxLength;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(labelText),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        counterText: '',
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
      inputFormatters: formatters,
      keyboardType: textInputType,
      maxLength: maxLength,
    );
  }
}
