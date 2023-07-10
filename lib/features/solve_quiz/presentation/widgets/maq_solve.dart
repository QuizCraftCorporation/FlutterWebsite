import 'package:capstone_project/core/domain/entity/multiple_answer_question_no_answer.dart';
import 'package:capstone_project/core/presentation/checkbox_cubit/checkbox_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MAQSolve extends StatelessWidget {
  const MAQSolve(
      {super.key,
      required this.maq,
      required this.number,
      required this.callback});

  final MultipleAnswerQuestionNoAnswer maq;
  final int number;
  final void Function(int, int, bool) callback;

  @override
  Widget build(BuildContext context) {
    List<Widget> text = [
      SelectableText(
        'Q$number. ${maq.questionText}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
    ];
    for (int i = 0; i < maq.options.length; i++) {
      text.add(
        ListTile(
          leading: BlocProvider<CheckboxCubit>(
            create: (context) => CheckboxCubit(),
            child: BlocBuilder<CheckboxCubit, CheckboxState>(
              builder: (context, state) {
                bool value = false;
                if (state is CheckboxTrue){
                  value = true;
                }
                return Checkbox(
                  onChanged: (value) {
                    callback(maq.id, maq.options[i].id, value!);
                    BlocProvider.of<CheckboxCubit>(context).changeState();
                  },
                  value: value,
                );
              },
            ),
          ),
          title: SelectableText(
            maq.options[i].text,
            // textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              height: 1.3,
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(
        top: 40,
        left: 35,
      ),
      width: MediaQuery.of(context).size.width / 2,
      // height: 150,
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 25, left: 30),
      decoration: BoxDecoration(
        color: const Color(0xFFE5DFF2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: text,
      ),
    );
  }
}
