import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../styles/styles.dart';

class CounterCard extends StatelessWidget {
  final int counter;

  const CounterCard({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
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
}
