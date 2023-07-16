import 'package:capstone_project/core/domain/entity/quiz_preview.dart';
import 'package:capstone_project/core/presentation/custom_error_widget.dart';
import 'package:capstone_project/core/presentation/loading.dart';
import 'package:capstone_project/core/presentation/title_widget.dart';
import 'package:capstone_project/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:capstone_project/features/explore/presentation/widgets/horizontal_scroll_list.dart';
import 'package:capstone_project/features/explore/presentation/widgets/quiz_preview_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.login});

  final bool login;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late ScrollController _views;
  late ScrollController _uniqueViews;
  late ScrollController _newest;
  late ScrollController _attempt;
  late ScrollController _recently;
  late ScrollController _main;

  @override
  void initState() {
    super.initState();
    _views = ScrollController();
    _uniqueViews = ScrollController();
    _newest = ScrollController();
    _attempt = ScrollController();
    _recently = ScrollController();
    _main = ScrollController();
  }

  @override
  void dispose() {
    _views.dispose();
    _uniqueViews.dispose();
    _newest.dispose();
    _attempt.dispose();
    _recently.dispose();
    _main.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        if (state is ExploreInitial) {
          BlocProvider.of<ExploreCubit>(context)
              .getAllLists(login: widget.login);
        }
        if (state is ExploreLoading) {
          return const Loading(text: 'Loading explore..');
        }
        if (state is ExploreLoaded) {
          return Scrollbar(
            trackVisibility: true,
            thumbVisibility: true,
            thickness: 10,
            controller: _main,
            child: SingleChildScrollView(
              controller: _main,
              child: Container(
                padding: const EdgeInsets.only(left: 25, right: 25),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleWidget(
                      title: 'Explore',
                      fontSize: 35,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 35),
                    ),
                    const TitleWidget(
                      title: 'Top Views',
                      fontSize: 30,
                      margin: EdgeInsets.only(top: 35, left: 50, bottom: 20),
                    ),
                    HorizontalScrollList(
                      scrollController: _views,
                      quizzes: state.views,
                    ),
                    const TitleWidget(
                      title: 'Top Unique Views',
                      fontSize: 30,
                      margin: EdgeInsets.only(top: 35, left: 50, bottom: 20),
                    ),
                    HorizontalScrollList(
                      scrollController: _uniqueViews,
                      quizzes: state.uniqueViews,
                    ),
                    const TitleWidget(
                      title: 'Newest',
                      fontSize: 30,
                      margin: EdgeInsets.only(top: 35, left: 50, bottom: 20),
                    ),
                    HorizontalScrollList(
                      scrollController: _newest,
                      quizzes: state.newest,
                    ),
                    const TitleWidget(
                      title: 'Most Attempted',
                      fontSize: 30,
                      margin: EdgeInsets.only(top: 35, left: 50, bottom: 20),
                    ),
                    HorizontalScrollList(
                      scrollController: _attempt,
                      quizzes: state.passes,
                    ),
                    widget.login
                        ? const TitleWidget(
                            title: 'You Recently Viewed',
                            fontSize: 30,
                            margin:
                                EdgeInsets.only(top: 35, left: 50, bottom: 20),
                          )
                        : Container(),
                    widget.login
                        ? HorizontalScrollList(
                            scrollController: _recently,
                            quizzes: state.recent,
                          )
                        : Container(),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is ExploreError) {
          return CustomError(message: state.message);
        }
        return const Loading(text: '');
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
