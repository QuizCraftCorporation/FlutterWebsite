import 'dart:math';
import 'package:capstone_project/features/create_quiz/presentation/cubit/create_quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/styles/theme.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _inputController;

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
    return SafeArea(
      child: BlocBuilder<CreateQuizCubit, CreateQuizState>(
        builder: (context, state) {
          if (state is CreateQuizInitial || state is CreateQuizError) {
            return Container(
              // TODO: подумай как тут нормальные отступы сделать
              margin: EdgeInsets.only(
                  top: 35,
                  bottom: 35,
                  left: max(MediaQuery.of(context).size.width / 6, 20),
                  right: MediaQuery.of(context).size.width / 6),
              child: ListView(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 40, right: 40),
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
                  SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    // width: max(MediaQuery.of(context).size.width / 4, 100),
                    child: TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Description (optional)',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                      ),
                      maxLines: 4,
                      minLines: 4,
                    ),
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
                  SizedBox(
                    // width: max(MediaQuery.of(context).size.width / 4, 100),
                    child: TextField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                        hintText:
                            'Input text (use only this field or file attachment)',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                      ),
                      maxLines: 8,
                      minLines: 8,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Attach file. Run FilePicker!!!
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
                  TextButton(
                    onPressed: () {
                      final cubit = BlocProvider.of<CreateQuizCubit>(context);
                      cubit.quizRequest(_titleController.text,
                          description: _descriptionController.text,
                          rawText: _inputController.text);
                    },
                    child: const Text('Complete'),
                  ),
                ],
              ),
            );
          } else if (state is CreateQuizLoading) {
            return const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator());
          } else {
            /// State is Loaded. Time to show a quiz
            // TODO: Navigate to ViewQuizScreen
          }
          return Container();
        },
      ),
    );
  }
}
