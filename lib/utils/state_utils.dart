import '../bloc/file_state.dart';
import '../constants/constants.dart';

class StateUtils {
  StateUtils._();

  static int getCounterFromState(FileState state) {
    return state is FileLoaded
        ? state.counter
        : state is FileLoading
        ? state.counter
        : state is FileError
        ? state.counter
        : 0;
  }

  static String getFileContentFromState(FileState state) {
    if (state is FileLoaded) {
      return state.fileContent;
    } else if (state is FileLoading) {
      return state.fileContent;
    } else if (state is FileError) {
      return state.errorMessage;
    }
    return AppConstants.emptyString;
  }
}
