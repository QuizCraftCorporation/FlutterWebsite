import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/presentation/custom_error_widget.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:capstone_project/core/presentation/title_widget.dart';
import 'package:capstone_project/features/create_quiz/presentation/cubit/create_quiz_cubit.dart';
import 'package:capstone_project/core/presentation/text_field_circular.dart';
import 'package:capstone_project/features/create_quiz/presentation/widgets/file_titles_cubit/file_titles_cubit.dart';
import 'package:capstone_project/core/presentation/checkbox_cubit/checkbox_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
            BlocProvider.of<CreateQuizCubit>(context).isFree();
          }
          if (state is CreateQuizCraftView) {
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
                  const TitleWidget(
                    title: 'Crafter',
                    fontSize: 30,
                    height: 50,
                    alignment: Alignment.center,
                  ),
                  const TitleWidget(
                    title: 'Quiz Settings',
                    fontSize: 20,
                    height: 50,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 450,
                    child: TextFieldCircular(
                      controller: _titleController,
                      lines: 1,
                      labelText: 'Title',
                      hint: '',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    // alignment: Alignment.topLeft,
                    width: 450,
                    child: TextFieldCircular(
                      controller: _descriptionController,
                      lines: 4,
                      labelText: 'Description',
                      hint: '(optional. Can be generated automatically)',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextFieldCircular(
                          controller: _numberOfQuestionsController,
                          lines: 1,
                          labelText: 'Number of Quiestions',
                          hint: ' [1, 45]',
                          textInputType: TextInputType.number,
                          formatters: [
                            FilteringTextInputFormatter.allow(RegExp(
                                r'(^0?[1-9]$)|(^1[0-9]$)|(^2[0-9]$)|(^3[0-9]$)|(^4[0-5]$)'))
                          ],
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
                  SizedBox(
                    width: 450,
                    child: TextFieldCircular(
                      controller: _inputController,
                      lines: 10,
                      labelText: 'Input text',
                      hint: '(you can attach files and also add raw text here)',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        var picked = await FilePicker.platform.pickFiles(
                            allowMultiple: true,
                            allowedExtensions: [
                              'txt',
                              'pdf',
                              'html',
                              'docx',
                              'pptx'
                            ],
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
                          Text('Attach files', style: TextStyle(fontSize: 20)),
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
                      return const Loading(text: '');
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
                        if (_titleController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                title: Text('Error'),
                                content: Text("Title shouldn't be empty"),
                              );
                            },
                          );
                        } else if (files.isEmpty &&
                            _inputController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                title: Text('Error'),
                                content:
                                    Text("Pass at least 1 file or Input text"),
                              );
                            },
                          );
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
                      child: const Text('Create quiz', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            );
          } else if (state is CreateQuizWaiting) {
            BlocProvider.of<CreateQuizCubit>(context)
                .checkCompletion(state.quizId);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleWidget(title: state.message, fontSize: 25, margin: const EdgeInsets.only(top: 100, bottom: 30),),
                LinearPercentIndicator(
                  alignment: MainAxisAlignment.center,
                  lineHeight: 25,
                  progressColor: Colors.blue,
                  width: 400,
                  percent: state.progress / 100,
                  center: Text('${state.progress.toInt()}%'),
                ),
              ],
            );
          } else if (state is CreateQuizLoaded) {
            return Column(
              children: [
                const TitleWidget(
                  title: 'Quiz Created',
                  fontSize: 30,
                  margin: EdgeInsets.only(top: 100, bottom: 20),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () =>
                          BlocProvider.of<CreateQuizCubit>(context)
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
                      onPressed: () =>
                          BlocProvider.of<CreateQuizCubit>(context)
                              .goToSolving(state.quizId),
                      child: const Text(
                        'Solving the quiz',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else if (state is CreateQuizError) {
            return CustomError(message: state.message);
            // TODO: Error handling
          }
          // Return something
          return const Loading(text: '');
        },
      ),
    );
  }
}
