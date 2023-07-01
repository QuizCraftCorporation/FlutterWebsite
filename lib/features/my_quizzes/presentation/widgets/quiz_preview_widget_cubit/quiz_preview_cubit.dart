import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quiz_preview_state.dart';

class QuizPreviewCubit extends Cubit<QuizPreviewState> {
  QuizPreviewCubit() : super(QuizPreviewInitial());

  void goToViewAnswers(){
    emit(QuizPreviewToViewAnswers());
  }

  void goToSolver(){
    emit(QuizPreviewToSolver());
  }
}
