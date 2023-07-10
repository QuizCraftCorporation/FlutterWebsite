part of 'explore_cubit.dart';

@immutable
abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<QuizPreview> views, uniqueViews, passes, newest, recent;
  ExploreLoaded(this.uniqueViews, this.passes, this.newest, this.views, this.recent);
}

class ExploreError extends ExploreState {}
