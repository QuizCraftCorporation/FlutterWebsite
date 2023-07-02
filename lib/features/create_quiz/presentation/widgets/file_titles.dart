import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileTitles extends StatelessWidget {
  const FileTitles({super.key, required this.files});

  final List<PlatformFile> files;

  @override
  Widget build(BuildContext context) {
    List<Widget> names = [];
    for (PlatformFile file in files) {
      names.add(
        Text(file.name, style: const TextStyle(fontSize: 20),),
      );
    }
    return Column(
      children: names,
    );
  }
}
