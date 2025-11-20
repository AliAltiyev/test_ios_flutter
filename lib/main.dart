import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'constants/constants.dart';
import 'styles/styles.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.uiAppTitle,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: BlocProvider(
        create: (context) => FileBloc()..add(const FileLoadRequested()),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.uiAppTitle)),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingDefault),
        child: BlocBuilder<FileBloc, FileState>(
          builder: (_, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCounter(state),
                const SizedBox(height: AppConstants.spacingLarge),
                _buildActionButton(context, state),
                const SizedBox(height: AppConstants.spacingLarge),
                const Text(
                  AppConstants.uiFileContentLabel,
                  style: AppStyles.fileContentLabelStyle,
                ),
                const SizedBox(height: AppConstants.spacingMedium),
                _buildFileContent(state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCounter(FileState state) {
    final counter = _getCounterFromState(state);
    return Text(
      '${AppConstants.uiCounterLabel} $counter',
      style: AppStyles.counterTextStyle,
    );
  }

  Widget _buildActionButton(BuildContext context, FileState state) {
    final isLoading = state is FileLoading;
    return ElevatedButton(
      onPressed: isLoading
          ? null
          : () => context.read<FileBloc>().add(
              const FileIncrementAndWriteRequested(),
            ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text(AppConstants.uiButtonText),
    );
  }

  Widget _buildFileContent(FileState state) {
    final content = _getFileContentFromState(state);
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppConstants.paddingDefault),
        decoration: AppStyles.fileContentContainerDecoration,
        child: SingleChildScrollView(
          child: Text(
            content.isEmpty ? AppConstants.uiEmptyFile : content,
            style: AppStyles.fileContentStyle,
          ),
        ),
      ),
    );
  }

  int _getCounterFromState(FileState state) {
    return state is FileLoaded
        ? state.counter
        : state is FileLoading
        ? state.counter
        : state is FileError
        ? state.counter
        : 0;
  }

  String _getFileContentFromState(FileState state) {
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
