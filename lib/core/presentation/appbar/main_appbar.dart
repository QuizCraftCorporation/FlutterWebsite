import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/data/api.dart';
import 'package:capstone_project/core/domain/main_auth_cubit/main_auth_cubit.dart';
import 'package:capstone_project/core/domain/main_auth_cubit/main_auth_cubit.dart';
import 'package:capstone_project/core/presentation/appbar/cubit/main_app_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../styles/theme.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key, required this.title, required this.searchCallback}) : super(key: key);

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
            // TODO: Fix navigation error. I guess the reason of error is context
            widget.searchCallback(state.search);
          }
          if (state is MainAppBarLogout) {
            AutoRouter.of(context).replaceNamed('/login');
          }
        },
        builder: (context, state) => AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset(
            'assets/logo_image/logo.png',
            scale: 4.5,
          ),
          backgroundColor: AppTheme.appbarBackgroundColor,
          shadowColor: Colors.black,
          actions: [
            SizedBox(
              width: 100,
              child: TextField(
                controller: _searchController,
                // TODO: create controller for this textfield
                onSubmitted: (String text) {
                  BlocProvider.of<MainAppBarCubit>(context)
                      .search(_searchController.text);
                },
                // TODO: Decoration
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      BlocProvider.of<MainAppBarCubit>(context)
                          .search(_searchController.text);
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
            ),
            // IconButton(
            //   onPressed: () {
            //     // BlocProvider.of<MainAppBarCubit>(context)
            //   },
            //   icon: const Icon(
            //     Icons.notifications,
            //     color: Colors.black,
            //   ),
            // ),
            // IconButton(
            //   onPressed: () {
            //     // BlocProvider.of<MainAppBarCubit>(context)
            //   },
            //   icon: const Icon(
            //     Icons.person,
            //     color: Colors.black,
            //   ),
            // ),

            // TODO: Don't show button when user isn't login
            BlocBuilder<MainAuthCubit, MainAuthState>(
              builder: (context, state) {
                if (state is! MainAuthIn) {
                  return Container();
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
