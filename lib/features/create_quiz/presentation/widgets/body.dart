import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:capstone_project/features/create_quiz/presentation/cubit/create_quiz_cubit.dart';
import 'package:capstone_project/core/presentation/text_field_circular.dart';
import 'package:capstone_project/features/create_quiz/presentation/widgets/file_titles_cubit/file_titles_cubit.dart';
import 'package:capstone_project/features/solve_quiz/presentation/widgets/checkbox_cubit/checkbox_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late TextEditingController _numberOfQuestionsController;
  List<PlatformFile> files = [];
  bool public = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _inputController = TextEditingController();
    _numberOfQuestionsController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _inputController.dispose();
    _numberOfQuestionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<CreateQuizCubit, CreateQuizState>(
        listener: (context, state) {
          if (state is CreateQuizGoToView) {
            AutoRouter.of(context).replaceNamed('/quiz/${state.quizId}/view');
          } else if (state is CreateQuizGoToSolving) {
            AutoRouter.of(context).replaceNamed('/quiz/${state.quizId}/solve');
          }
        },
        builder: (context, state) {
          if (state is CreateQuizInitial) {
            return Container(
              width: MediaQuery.of(context).size.width - 200,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                top: 35,
                left: MediaQuery.of(context).size.width / 10,
                right: MediaQuery.of(context).size.width / 10,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Mode: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'private',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      BlocProvider(
                        create: (context) => CheckboxCubit(),
                        child: BlocBuilder<CheckboxCubit, CheckboxState>(
                          builder: (context, state) {
                            return Switch(
                              value: public,
                              onChanged: (newValue) {
                                public = newValue;
                                BlocProvider.of<CheckboxCubit>(context)
                                    .changeState();
                              },
                            );
                          },
                        ),
                      ),
                      const Text(
                        'public',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
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
                  SizedBox(
                    width: 200,
                    child: TextFieldCircular(
                      controller: _numberOfQuestionsController,
                      lines: 1,
                      hint: 'Number of questions',
                      textInputType: TextInputType.number,
                      formatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 3,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () async {
                      // TODO: Attach file. Run FilePicker!!!
                      var picked = await FilePicker.platform.pickFiles(
                          allowMultiple: true,
                          allowedExtensions: ['txt', 'pdf'],
                          type: FileType.custom);
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
                        Text('Attach files'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<FileTitlesCubit, FileTitlesState>(
                    builder: (context, state) {
                      if (state is FileTitlesInitial) {
                        List<Widget> names = [];
                        for (PlatformFile file in files) {
                          names.add(
                            ListTile(
                              // isThreeLine: true,
                              shape: const Border(bottom: BorderSide()),
                              title: Text(
                                file.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  files.remove(file);
                                  BlocProvider.of<FileTitlesCubit>(context)
                                      .deleteFile();
                                },
                                icon:
                                    const Icon(Icons.highlight_remove_outlined),
                              ),
                            ),
                          );
                        }
                        return Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: names,
                        );
                      }
                      if (state is FileTitlesAddingFiles) {
                        return const Loading(text: 'adding files');
                      }
                      if (state is FileTitlesDeleteFile) {
                        return const Loading(text: 'deleting files');
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      int numberOfQuestions = 0;
                      if (_numberOfQuestionsController.text.isNotEmpty) {
                        numberOfQuestions =
                            int.parse(_numberOfQuestionsController.text);
                      }
                      final cubit = BlocProvider.of<CreateQuizCubit>(context);
                      cubit.quizRequest(
                        _titleController.text,
                        _descriptionController.text,
                        _inputController.text,
                        files,
                        numberOfQuestions,
                        public,
                      );
                    },
                    child: const Text('Create quiz'),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            );
          } else if (state is CreateQuizLoading) {
            return const Loading(
              text: 'Do magic for quiz creation\nYou can leave this page',
            );
          } else if (state is CreateQuizLoaded) {
            return const Text(
              'Quiz created',
              style: TextStyle(
                fontSize: 25,
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
