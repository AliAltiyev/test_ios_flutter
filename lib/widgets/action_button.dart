import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../constants/constants.dart';
import '../styles/styles.dart';

class ActionButton extends StatelessWidget {
  final FileState state;

  const ActionButton({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
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
}
