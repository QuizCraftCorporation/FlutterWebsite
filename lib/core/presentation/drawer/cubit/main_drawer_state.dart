part of 'main_drawer_cubit.dart';

@immutable
abstract class MainDrawerState {}

class MainDrawerInitial extends MainDrawerState {}

class MainDrawerToCreateQuizState extends MainDrawerState {}

class MainDrawerToMyQuizzesState extends MainDrawerState {}

class MainDrawerToSettingsState extends MainDrawerState {}

class MainDrawerToHelpState extends MainDrawerState {}
