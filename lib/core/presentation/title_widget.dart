import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title, required this.fontSize, this.height, this.alignment, this.margin});

  final String title;
  final double fontSize;
  final double? height;
  final AlignmentGeometry? alignment;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      height: height,
      margin: margin,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
