part of 'main_drawer_cubit.dart';

@immutable
abstract class MainDrawerState {}

class MainDrawerInitial extends MainDrawerState {}

class MainDrawerToCreateQuizState extends MainDrawerState {}

class MainDrawerToMyQuizzesState extends MainDrawerState {}

class MainDrawerToExploreState extends MainDrawerState {}

class MainDrawerToAllQuizzesState extends MainDrawerState {}

class MainDrawerToHelpState extends MainDrawerState {}
