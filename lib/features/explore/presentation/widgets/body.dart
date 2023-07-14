import 'package:capstone_project/core/domain/entity/quiz_preview.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:capstone_project/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:capstone_project/features/explore/presentation/widgets/quiz_preview_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.login});

  final bool login;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExploreCubit, ExploreState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is ExploreInitial) {
          BlocProvider.of<ExploreCubit>(context).getAllLists(login: login);
        }
        if (state is ExploreLoading) {
          return const Loading(text: 'Loading lists');
        }
        if (state is ExploreLoaded) {
          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 35),
                    // alignment: Alignment.topCenter,
                    child: const Text(
                      'Explore',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 35, left: 50, bottom: 20),
                    // alignment: Alignment.topCenter,
                    child: const Text(
                      'Top views',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: convertToWidgets(state.views),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 35, left: 50, bottom: 20),
                    // alignment: Alignment.topCenter,
                    child: const Text(
                      'Top unique views',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: convertToWidgets(state.uniqueViews),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 35, left: 50, bottom: 20),
                    // alignment: Alignment.topCenter,
                    child: const Text(
                      'Newest',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: convertToWidgets(state.newest),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 35, left: 50, bottom: 20),
                    // alignment: Alignment.topCenter,
                    child: const Text(
                      'Top by passes',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: convertToWidgets(state.passes),
                    ),
                  ),
                  login
                      ? Container(
                          margin: const EdgeInsets.only(
                              top: 35, left: 50, bottom: 20),
                          // alignment: Alignment.topCenter,
                          child: const Text(
                            'You recently viewed',
                            style: TextStyle(fontSize: 25),
                          ),
                        )
                      : Container(),
                  login
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: convertToWidgets(state.recent),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          );
        }
        if (state is ExploreError) {
          //TODO: Error!!!
        }
        return Container();
      },
    );
  }

  List<Widget> convertToWidgets(List<QuizPreview> quizzes) {
    List<Widget> result = [];
    for (QuizPreview quizPreview in quizzes) {
      result.add(QuizPreviewCardWidget(quizPreview: quizPreview));
    }
    return result;
  }
}