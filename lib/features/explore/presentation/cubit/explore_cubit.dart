import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/api.dart';
import 'package:capstone_project/core/domain/entity/quiz_preview.dart';
import 'package:meta/meta.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreInitial());

  Future<void> getAllLists() async {
    emit(ExploreLoading());
    try {
      List<QuizPreview> passes = await API.getExploreCategory('passes');
      List<QuizPreview> views = await API.getExploreCategory('views');
      List<QuizPreview> uniqueViews = await API.getExploreCategory('unique_views');
      List<QuizPreview> newest = await API.getExploreCategory('generations');

      // TODO: Check is user login or not. If yes, then show the history
      // List<QuizPreview> history = await API.getExploreCategory('passes');

      emit(ExploreLoaded(uniqueViews, passes, newest, views: views));
    } catch (e) {
      emit(ExploreError());
    }
  }
}
