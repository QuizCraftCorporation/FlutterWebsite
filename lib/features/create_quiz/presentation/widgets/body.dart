import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/presentation/custom_error_widget.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:capstone_project/features/create_quiz/presentation/cubit/create_quiz_cubit.dart';
import 'package:capstone_project/core/presentation/text_field_circular.dart';
import 'package:capstone_project/features/create_quiz/presentation/widgets/file_titles_cubit/file_titles_cubit.dart';
import 'package:capstone_project/core/presentation/checkbox_cubit/checkbox_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  int numberOfQuestion = 1;

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
            AutoRouter.of(context).pushNamed('/quiz/${state.quizId}/view');
          } else if (state is CreateQuizGoToSolving) {
            AutoRouter.of(context).pushNamed('/quiz/${state.quizId}/solve');
          }
        },
        builder: (context, state) {
          if (state is CreateQuizInitial) {
            return Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                top: 35,
                left: MediaQuery.of(context).size.width / 10,
                right: MediaQuery.of(context).size.width / 10,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: const Text(
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
                      'Quiz Settings',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 450,
                    child: TextFieldCircular(
                      controller: _titleController,
                      lines: 1,
                      hint: 'Title',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    // alignment: Alignment.topLeft,
                    width: 450,
                    child: TextFieldCircular(
                      controller: _descriptionController,
                      lines: 4,
                      hint: 'Description (optional)',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Slider(value: numberOfQuestion.toDouble(), min: 1.0, max: 45.0, onChanged: (newValue){numberOfQuestion = newValue.toInt();}),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextFieldCircular(
                          controller: _numberOfQuestionsController,
                          lines: 1,
                          hint: 'Questions [1, 45]',
                          textInputType: TextInputType.number,
                          formatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 2,
                        ),
                      ),
                      SizedBox(
                        width: min(165, MediaQuery.of(context).size.width / 10),
                      ),
                      const Text(
                        'Public',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      BlocProvider(
                        create: (context) => CheckboxCubit(),
                        child: BlocBuilder<CheckboxCubit, CheckboxState>(
                          builder: (context, state) {
                            return Checkbox(
                              value: public,
                              onChanged: (newValue) {
                                newValue ??= false;
                                public = newValue;
                                BlocProvider.of<CheckboxCubit>(context)
                                    .changeState();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
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
                  Center(
                    child: TextButton(
                      onPressed: () async {
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
                  Container(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        int numberOfQuestions = 0;
                        if (_numberOfQuestionsController.text.isNotEmpty) {
                          numberOfQuestions =
                              int.parse(_numberOfQuestionsController.text);
                        }
                        if (_titleController.text.length == 0){
                          showDialog(
                            context: context, builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text("Title shouldn't be empty"),
                            );
                          },);
                        } else if (files.length == 0 && _inputController.text.length == 0){
                          showDialog(
                            context: context, builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text("Pass at least 1 file or Input text"),
                            );
                          },);
                        } else {
                          final cubit =
                              BlocProvider.of<CreateQuizCubit>(context);
                          cubit.quizRequest(
                            _titleController.text,
                            _descriptionController.text,
                            _inputController.text,
                            files,
                            numberOfQuestions,
                            public,
                          );
                        }
                      },
                      child: const Text('Create quiz'),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            );
          } else if (state is CreateQuizLoading || state is CreateQuizWaiting) {
            return const Loading(
              text: 'Do magic for quiz creation\nYou can leave this page',
            );
          } else if (state is CreateQuizLoaded) {
            return Container(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  TextButton(
                    onPressed: () => BlocProvider.of<CreateQuizCubit>(context)
                        .goToView(state.quizId),
                    child: const Text(
                      'View the quiz',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  TextButton(
                    onPressed: () => BlocProvider.of<CreateQuizCubit>(context)
                        .goToSolving(state.quizId),
                    child: const Text(
                      'Solving the quiz',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
            // return const Center(
            //   child: Text(
            //     'Quiz created',
            //     style: TextStyle(
            //       fontSize: 25,
            //     ),
            //   ),
            // );
          } else if (state is CreateQuizError) {
            return CustomError(message: state.message);
            // TODO: Error handling
          }
          // Return something
          return Container();
        },
      ),
    );
  }
}
