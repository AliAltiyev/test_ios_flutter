import 'package:equatable/equatable.dart';

abstract class FileEvent extends Equatable {
  const FileEvent();

  @override
  List<Object?> get props => [];
}

class FileLoadRequested extends FileEvent {
  const FileLoadRequested();
}

class FileIncrementAndWriteRequested extends FileEvent {
  const FileIncrementAndWriteRequested();
}
