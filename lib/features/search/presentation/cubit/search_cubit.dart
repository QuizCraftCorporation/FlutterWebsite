import 'package:bloc/bloc.dart';
import 'package:capstone_project/core/data/api.dart';
import 'package:flutter/material.dart';
import '../../../../core/domain/entity/quiz_preview.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> searchQuizzes(String search) async{
    emit(SearchLoading());
    try {
      List<QuizPreview> quizzes = await API.searchQuizzes(search);
      emit(SearchResult(quizzes: quizzes));
    } catch (e) {
      emit(SearchError());
      // TODO: Additional handling
    }
  }
}
