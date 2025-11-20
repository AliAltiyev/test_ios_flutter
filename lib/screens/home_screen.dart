import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../constants/constants.dart';
import '../styles/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.uiAppTitle),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: AppStyles.backgroundGradient),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppStyles.backgroundGradient),
        child: SafeArea(
          child: BlocBuilder<FileBloc, FileState>(
            builder: (_, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.paddingDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildCounterCard(state),
                    const SizedBox(height: AppConstants.spacingLarge),
                    _buildActionButton(context, state),
                    const SizedBox(height: AppConstants.spacingLarge),
                    _buildFileContentCard(state),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCounterCard(FileState state) {
    final counter = _getCounterFromState(state);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * value),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppConstants.paddingLarge + 8,
                horizontal: AppConstants.paddingLarge,
              ),
              decoration: AppStyles.cardDecoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppConstants.uiCounterLabel,
                    style: AppStyles.counterLabelStyle,
                  ),
                  const SizedBox(height: AppConstants.spacingSmall + 4),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutBack,
                            ),
                          ),
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      '$counter',
                      key: ValueKey(counter),
                      style: AppStyles.counterTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(BuildContext context, FileState state) {
    final isLoading = state is FileLoading;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: 60,
              decoration: isLoading
                  ? AppStyles.gradientButtonDecoration.copyWith(
                      gradient: LinearGradient(
                        colors: [
                          AppStyles.primaryColor.withValues(alpha: 0.7),
                          AppStyles.primaryLight.withValues(alpha: 0.7),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppStyles.primaryColor.withValues(alpha: 0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    )
                  : AppStyles.gradientButtonDecoration,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: isLoading
                      ? null
                      : () {
                          context.read<FileBloc>().add(
                            const FileIncrementAndWriteRequested(),
                          );
                        },
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadiusSmall,
                  ),
                  splashColor: Colors.white.withOpacity(0.2),
                  highlightColor: Colors.white.withOpacity(0.1),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingLarge + 8,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 26,
                            height: 26,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.add_circle_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                              const SizedBox(
                                width: AppConstants.spacingSmall + 2,
                              ),
                              Flexible(
                                child: Text(
                                  AppConstants.uiButtonText,
                                  style: AppStyles.buttonTextStyle,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFileContentCard(FileState state) {
    final content = _getFileContentFromState(state);
    final isEmpty = content.isEmpty;
    final isError = state is FileError;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 40 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              constraints: const BoxConstraints(minHeight: 220, maxHeight: 420),
              padding: const EdgeInsets.all(AppConstants.paddingLarge + 4),
              decoration: AppStyles.fileContentContainerDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      bottom: AppConstants.paddingDefault,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppStyles.borderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isEmpty
                                ? AppStyles.textTertiary.withOpacity(0.1)
                                : isError
                                ? AppStyles.errorColor.withOpacity(0.1)
                                : AppStyles.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            isEmpty
                                ? Icons.description_outlined
                                : isError
                                ? Icons.error_outline_rounded
                                : Icons.description_rounded,
                            color: isEmpty
                                ? AppStyles.textSecondary
                                : isError
                                ? AppStyles.errorColor
                                : AppStyles.primaryColor,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: AppConstants.spacingSmall + 2),
                        Expanded(
                          child: Text(
                            AppConstants.uiFileContentLabel,
                            style: AppStyles.fileContentLabelStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppConstants.paddingDefault),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: isEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: AppStyles.textTertiary
                                            .withOpacity(0.05),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.inbox_outlined,
                                        size: 56,
                                        color: AppStyles.textTertiary,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: AppConstants.spacingMedium + 4,
                                    ),
                                    Text(
                                      AppConstants.uiEmptyFile,
                                      style: AppStyles.emptyFileStyle,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SelectableText(
                              content,
                              style: AppStyles.fileContentStyle.copyWith(
                                color: isError
                                    ? AppStyles.errorColor
                                    : AppStyles.textPrimary,
                                fontWeight: isError
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
