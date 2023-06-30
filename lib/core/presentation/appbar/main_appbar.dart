import 'package:auto_route/auto_route.dart';
import 'package:capstone_project/core/data/api.dart';
import 'package:capstone_project/core/presentation/appbar/cubit/main_app_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../styles/theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainAppBarCubit>(
      create: (context) => MainAppBarCubit(),
      child: BlocConsumer<MainAppBarCubit, MainAppBarState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is MainAppBarLogout){
            AutoRouter.of(context).navigateNamed('/login');
          }
        },
        builder: (context, state) =>
            AppBar(
              title: Image.asset('assets/logo_image/logo.png', scale: 4.5,),
              backgroundColor: AppTheme.appbarBackgroundColor,
              shadowColor: Colors.black,
              actions: [
                IconButton(
                  onPressed: () {
                    // BlocProvider.of<MainAppBarCubit>(context)
                  },
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // BlocProvider.of<MainAppBarCubit>(context)
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
                // TODO: Don't show button when user isn't login
                TextButton(
                  onPressed: () {
                    BlocProvider.of<MainAppBarCubit>(context).logout();
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
