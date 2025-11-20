import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/services.dart';
import '../constants/constants.dart';
import 'file_event.dart';
import 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final NativeChannelService _nativeService;

  FileBloc({NativeChannelService? nativeService})
    : _nativeService = nativeService ?? NativeChannelService.instance,
      super(const FileInitial()) {
    on<FileLoadRequested>(_onFileLoadRequested);
    on<FileIncrementAndWriteRequested>(_onFileIncrementAndWriteRequested);
  }

  Future<void> _onFileLoadRequested(
    FileLoadRequested event,
    Emitter<FileState> emit,
  ) async {
    try {
      final content = await _nativeService.readFile();
      emit(FileLoaded(counter: _getCurrentCounter(), fileContent: content));
    } on NativeChannelException catch (e) {
      emit(
        FileError(
          counter: _getCurrentCounter(),
          fileContent: AppConstants.emptyString,
          errorMessage: '${AppConstants.uiReadErrorPrefix} ${e.message}',
        ),
      );
    } catch (e) {
      emit(
        FileError(
          counter: _getCurrentCounter(),
          fileContent: AppConstants.emptyString,
          errorMessage: '${AppConstants.uiReadErrorPrefix} $e',
        ),
      );
    }
  }

  Future<void> _onFileIncrementAndWriteRequested(
    FileIncrementAndWriteRequested event,
    Emitter<FileState> emit,
  ) async {
    final currentCounter = _getCurrentCounter();
    final newCounter = currentCounter + 1;
    final currentContent = _getCurrentFileContent();

    emit(FileLoading(counter: newCounter, fileContent: currentContent));

    try {
      await _nativeService.writeToFile(newCounter);
      final content = await _nativeService.readFile();
      emit(FileLoaded(counter: newCounter, fileContent: content));
    } on NativeChannelException catch (e) {
      emit(
        FileError(
          counter: newCounter,
          fileContent: currentContent,
          errorMessage: '${AppConstants.uiErrorPrefix} ${e.message}',
        ),
      );
    } catch (e) {
      emit(
        FileError(
          counter: newCounter,
          fileContent: currentContent,
          errorMessage: '${AppConstants.uiErrorPrefix} $e',
        ),
      );
    }
  }

  int _getCurrentCounter() {
    return state is FileLoaded
        ? (state as FileLoaded).counter
        : state is FileLoading
        ? (state as FileLoading).counter
        : state is FileError
        ? (state as FileError).counter
        : 0;
  }

  String _getCurrentFileContent() {
    return state is FileLoaded
        ? (state as FileLoaded).fileContent
        : state is FileLoading
        ? (state as FileLoading).fileContent
        : state is FileError
        ? (state as FileError).fileContent
        : AppConstants.emptyString;
  }
}
