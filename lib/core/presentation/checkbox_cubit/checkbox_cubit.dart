import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'checkbox_state.dart';

class CheckboxCubit extends Cubit<CheckboxState> {
  CheckboxCubit() : super(CheckboxFalse());

  void changeState(){
    if (state is CheckboxFalse){
      emit(CheckboxTrue());
    } else {
      emit(CheckboxFalse());
    }
  }
}
