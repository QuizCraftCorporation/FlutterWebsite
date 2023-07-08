import 'package:capstone_project/core/domain/entity/quiz_preview.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone_project/core/presentation/quiz_preview/quiz_preview_widget.dart';
import '../cubit/search_cubit.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.search, });

  final String search;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // TODO: replace const size of drawer (200) with some dynamic size
        width: MediaQuery
            .of(context)
            .size
            .width - 200,
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchInitial){
              BlocProvider.of<SearchCubit>(context).searchQuizzes(search);
            }
            if (state is SearchLoading) {
              return const Loading(text: 'Searching');
            }
            if (state is SearchResult) {
              List<Widget> prevs = [];
              for (QuizPreview quizPreview in state.quizzes){
                prevs.add(QuizPreviewWidget(quizPreview: quizPreview));
              }
              // print(prevs.length);
              return Column(
                children: prevs,
              );
            }
            if (state is SearchError) {
              // TODO: create "common error" widget
              return Container();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
