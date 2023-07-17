import 'package:capstone_project/core/domain/entity/quiz_preview.dart';
import 'package:capstone_project/core/presentation/custom_error_widget.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone_project/core/presentation/quiz_preview/quiz_preview_widget.dart';
import '../cubit/search_cubit.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.search,
  });

  final String search;

  @override
  Widget build(BuildContext context) {
    String beautySearch = search.replaceAll('%20', ' ');
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if (state is SearchInitial) {
              BlocProvider.of<SearchCubit>(context).searchQuizzes(beautySearch);
            }
            if (state is SearchLoading) {
              return const Loading(text: 'Searching');
            }
            if (state is SearchResult) {
              List<Widget> prevs = [];
              for (QuizPreview quizPreview in state.quizzes) {
                prevs.add(QuizPreviewWidget(quizPreview: quizPreview));
              }
              if (prevs.isEmpty) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(35),
                      child: Text(
                        'Cannot found any quizzes related with $beautySearch',
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(35),
                    child: Text(
                      'Results for query: $beautySearch',
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  Column(
                    children: prevs,
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                ],
              );
            }
            if (state is SearchError) {
              return CustomError(message: state.message);
            }
            return const Loading(text: '');
          },
        ),
      ),
    );
  }
}
