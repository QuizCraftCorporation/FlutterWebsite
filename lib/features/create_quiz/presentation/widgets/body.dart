import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:capstone_project/features/create_quiz/presentation/cubit/create_quiz_cubit.dart';
import 'package:capstone_project/core/presentation/text_field_circular.dart';
import 'package:capstone_project/features/create_quiz/presentation/widgets/file_titles.dart';
import 'package:capstone_project/features/create_quiz/presentation/widgets/file_titles_cubit/file_titles_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _inputController;
  List<PlatformFile> files = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _inputController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<CreateQuizCubit, CreateQuizState>(
        listener: (context, state) {
          if (state is CreateQuizGoToView) {
            AutoRouter.of(context).replaceNamed('/quiz/${state.quizId}');
          } else if (state is CreateQuizGoToSolving) {
            AutoRouter.of(context).replaceNamed('/quiz/solve/${state.quizId}');
          }
        },
        builder: (context, state) {
          if (state is CreateQuizInitial) {
            return Container(
              width: MediaQuery.of(context).size.width / 2,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(
                top: 35,
                left: MediaQuery.of(context).size.width / 10,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                    child: Text(
                      'Crafter',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                    child: Text(
                      'Quiz Info',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFieldCircular(
                    controller: _titleController,
                    lines: 1,
                    hint: 'Title',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldCircular(
                    controller: _descriptionController,
                    lines: 4,
                    hint: 'Description (optional)',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 50,
                    child: Text(
                      'Input data',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFieldCircular(
                    controller: _inputController,
                    lines: 10,
                    hint: 'Input text',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () async {
                      // TODO: Attach file. Run FilePicker!!!
                      var picked = await FilePicker.platform.pickFiles();
                      if (picked != null) {
                        for (PlatformFile file in picked.files) {
                          files.add(file);
                        }
                        BlocProvider.of<FileTitlesCubit>(context).addFile();
                      }
                    },
                    child: const ButtonBar(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.upload),
                        Text('Attach file'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<FileTitlesCubit, FileTitlesState>(
                    builder: (context, state) {
                      if (state is FileTitlesInitial){
                        return FileTitles(files: files);
                      }
                      if (state is FileTitlesAddingFiles) {
                        return const Loading(text: 'adding files');
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      final cubit = BlocProvider.of<CreateQuizCubit>(context);
                      cubit.quizRequest(
                        _titleController.text,
                        _descriptionController.text,
                        _inputController.text,
                        files,
                      );
                    },
                    child: const Text('Complete'),
                  ),
                ],
              ),
            );
          } else if (state is CreateQuizLoading) {
            return const Loading(
              text: 'Do magic for quiz creation',
            );
          } else if (state is CreateQuizLoaded) {
            return Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 3,
                left: MediaQuery.of(context).size.width / 3,
              ),
              // alignment: Alignment.center,
              child: const Text(
                'Quiz created',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            );
          } else if (state is CreateQuizError) {
            // TODO: Error handling
          }
          // Return something
          return Container();
        },
      ),
    );
  }
}
