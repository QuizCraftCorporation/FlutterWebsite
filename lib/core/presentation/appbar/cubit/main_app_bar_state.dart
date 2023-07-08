part of 'main_app_bar_cubit.dart';

@immutable
abstract class MainAppBarState {}

class MainAppBarInitial extends MainAppBarState {}

class MainAppBarLogout extends MainAppBarState {}

class MainAppBarProfile extends MainAppBarState {}

class MainAppBarNotification extends MainAppBarState {}

class MainAppBarSearch extends MainAppBarState {
  final String search;
  MainAppBarSearch({required this.search});
}
