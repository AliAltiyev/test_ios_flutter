import 'package:equatable/equatable.dart';

abstract class FileState extends Equatable {
  const FileState();

  @override
  List<Object?> get props => [];
}

class FileInitial extends FileState {
  const FileInitial();
}

class FileLoading extends FileState {
  final int counter;
  final String fileContent;

  const FileLoading({required this.counter, required this.fileContent});

  @override
  List<Object?> get props => [counter, fileContent];
}

class FileLoaded extends FileState {
  final int counter;
  final String fileContent;

  const FileLoaded({required this.counter, required this.fileContent});

  @override
  List<Object?> get props => [counter, fileContent];
}

class FileError extends FileState {
  final int counter;
  final String fileContent;
  final String errorMessage;

  const FileError({
    required this.counter,
    required this.fileContent,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [counter, fileContent, errorMessage];
}
