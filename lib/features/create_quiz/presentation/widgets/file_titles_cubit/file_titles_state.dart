part of 'file_titles_cubit.dart';

@immutable
abstract class FileTitlesState {}

class FileTitlesInitial extends FileTitlesState {}

class FileTitlesAddingFiles extends FileTitlesState {}

class FileTitlesDeleteFile extends FileTitlesState {}
