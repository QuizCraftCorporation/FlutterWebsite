import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/data/api.dart';
import '../../../../core/domain/entity/quiz_preview.dart';

part 'all_quizzes_state.dart';

class AllQuizzesCubit extends Cubit<AllQuizzesState> {
  AllQuizzesCubit() : super(AllQuizzesInitial());

  Future<void> getAllQuizzes() async {
    emit(AllQuizzesLoading());
    try {
      List<QuizPreview> quizzes = await API.getExploreCategory('views', limit: 1000);
      emit(AllQuizzesLoaded(quizzes: quizzes));
    } catch (e) {
      emit(AllQuizzesError(message: e.toString()));
    }
  }
}
