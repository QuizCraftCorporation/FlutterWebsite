import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/domain/main_auth_cubit/main_auth_cubit.dart';
import 'package:capstone_project/core/presentation/appbar/cubit/main_app_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../styles/theme.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar(
      {Key? key, required this.title, required this.searchCallback})
      : super(key: key);

  final String title;
  final Function searchCallback;

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainAppBarCubit>(
      create: (context) => MainAppBarCubit(),
      child: BlocConsumer<MainAppBarCubit, MainAppBarState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is MainAppBarSearch) {
            widget.searchCallback(state.search);
          }
          if (state is MainAppBarLogout || state is MainAppBarLogin) {
            AutoRouter.of(context).replaceNamed('/login');
          }
          if (state is MainAppBarExplore) {
            AutoRouter.of(context).navigateNamed('/explore');
          }
        },
        builder: (context, state) => AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          title: Image.asset(
            'assets/logo_image/logo.png',
            scale: 7,
          ),
          backgroundColor: AppTheme.appbarBackgroundColor,
          shadowColor: Colors.black,
          actions: [
            MediaQuery.of(context).size.width > 650
                ? Container(
                    margin: EdgeInsets.only(
                        right: min(35, MediaQuery.of(context).size.width / 10)),
                    child: TextButton.icon(
                      icon: const Icon(Icons.explore),
                      label: const Text('Explore'),
                      onPressed: () {
                        BlocProvider.of<MainAppBarCubit>(context).goToExplore();
                      },
                    ),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 10),
              width: min(300, MediaQuery.of(context).size.width / 3),
              child: TextField(
                controller: _searchController,
                onSubmitted: (String text) {
                  BlocProvider.of<MainAppBarCubit>(context)
                      .search(_searchController.text);
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    onPressed: () {
                      BlocProvider.of<MainAppBarCubit>(context)
                          .search(_searchController.text);
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
            BlocBuilder<MainAuthCubit, MainAuthState>(
              builder: (context, state) {
                if (state is! MainAuthIn) {
                  return TextButton(
                    onPressed: () {
                      BlocProvider.of<MainAppBarCubit>(context).login();
                    },
                    child: const Text('Login'),
                  );
                }
                return TextButton(
                  onPressed: () {
                    BlocProvider.of<MainAppBarCubit>(context).logout();
                  },
                  child: const Text('Logout'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
