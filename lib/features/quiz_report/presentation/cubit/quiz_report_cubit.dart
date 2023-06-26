import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'quiz_report_state.dart';

class QuizReportCubit extends Cubit<QuizReportState> {
  QuizReportCubit() : super(QuizReportInitial());
}
