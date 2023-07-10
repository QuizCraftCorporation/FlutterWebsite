import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/appbar/main_appbar.dart';
import '../../../core/presentation/drawer/main_drawer.dart';
import 'cubit/search_cubit.dart';
import 'widgets/body.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, @PathParam('query') required this.search});

  final String search;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      child: Scaffold(
        appBar: MainAppBar(
          title: 'Quiz',
          searchCallback: (String searchQuery) {
            AutoRouter.of(context).pushNamed('/search/$searchQuery');
          },
        ),
        drawer: const MainDrawer(),
        body: Body(
          search: search,
        ),
      ),
      create: (BuildContext context) => SearchCubit(),
    );
  }
}
