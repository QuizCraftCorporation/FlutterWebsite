import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'file_titles_state.dart';

class FileTitlesCubit extends Cubit<FileTitlesState> {
  FileTitlesCubit() : super(FileTitlesInitial());

  Future<void> addFile() async {
    emit(FileTitlesAddingFiles());
    emit(FileTitlesInitial());
  }

  Future<void> deleteFile() async {
    emit(FileTitlesDeleteFile());
    emit(FileTitlesInitial());
  }
}
