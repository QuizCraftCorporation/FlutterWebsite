part of 'checkbox_cubit.dart';

@immutable
abstract class CheckboxState {}

class CheckboxFalse extends CheckboxState {
  final bool value = false;
}

class CheckboxTrue extends CheckboxState {
  final bool value = true;
}
