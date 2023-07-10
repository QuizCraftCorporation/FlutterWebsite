import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quiz_preview_card_state.dart';

class QuizPreviewCardCubit extends Cubit<QuizPreviewCardState> {
  QuizPreviewCardCubit() : super(QuizPreviewCardInitial());

  Future<void> goToView() async{
    emit(QuizPreviewCardGoView());
  }

  Future<void> goToSolve() async{
    emit(QuizPreviewCardGoSolve());
  }

}
