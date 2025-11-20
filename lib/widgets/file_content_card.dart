import 'package:flutter/material.dart';
import '../bloc/file_state.dart';
import '../constants/constants.dart';
import '../styles/styles.dart';

class FileContentCard extends StatelessWidget {
  final FileState state;

  const FileContentCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final content = _getFileContentFromState();
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
                  _buildHeader(isEmpty, isError),
                  const SizedBox(height: AppConstants.paddingDefault),
                  Expanded(child: _buildContent(content, isEmpty, isError)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isEmpty, bool isError) {
    return Container(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingDefault),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppStyles.borderColor, width: 1),
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
    );
  }

  Widget _buildContent(String content, bool isEmpty, bool isError) {
    return SingleChildScrollView(
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
                        color: AppStyles.textTertiary.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.inbox_outlined,
                        size: 56,
                        color: AppStyles.textTertiary,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium + 4),
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
                color: isError ? AppStyles.errorColor : AppStyles.textPrimary,
                fontWeight: isError ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
    );
  }

  String _getFileContentFromState() {
    if (state is FileLoaded) {
      return (state as FileLoaded).fileContent;
    } else if (state is FileLoading) {
      return (state as FileLoading).fileContent;
    } else if (state is FileError) {
      return (state as FileError).errorMessage;
    }
    return AppConstants.emptyString;
  }
}
