import 'package:capstone_project/core/domain/entity/quiz_preview.dart';
import 'package:capstone_project/core/presentation/custom_error_widget.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:capstone_project/features/my_quizzes/presentation/cubit/my_quizzes_cubit.dart';
import 'package:capstone_project/core/presentation/quiz_preview/quiz_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<MyQuizzesCubit, MyQuizzesState>(
          builder: (context, state) {
            if (state is MyQuizzesInitial) {
              BlocProvider.of<MyQuizzesCubit>(context).getMyQuizzes();
            }
            if (state is MyQuizzesLoading) {
              return const Loading(text: 'Loading quizzes');
            }
            if (state is MyQuizzesList) {
              List<Widget> prevs = [];
              for (QuizPreview quizPreview in state.quizzes) {
                prevs.add(QuizPreviewWidget(quizPreview: quizPreview));
              }
              if (prevs.length == 0){
                return const Center(child: Text("You don't have any quizzes. Go and generate some", style: TextStyle(fontSize: 25),),);
              }
              return Column(
                children: prevs,
              );
            }
            if (state is MyQuizzesError) {
              // TODO: create "common error" widget
              return CustomError(message: state.message);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
