import 'package:flutter/material.dart';
import '../constants/constants.dart';

class AppStyles {
  AppStyles._();

  static const Color primaryColor = Color(0xFF5B21B6);
  static const Color primaryLight = Color(0xFF7C3AED);
  static const Color primaryDark = Color(0xFF4C1D95);
  static const Color secondaryColor = Color(0xFF7E22CE);
  static const Color accentColor = Color(0xFFA855F7);
  static const Color backgroundColor = Color(0xFFFAFBFC);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFF8F9FA);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color successColor = Color(0xFF059669);
  static const Color errorColor = Color(0xFFDC2626);
  static const Color borderColor = Color(0xFFE2E8F0);

  static LinearGradient primaryGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, primaryLight, accentColor],
    stops: [0.0, 0.5, 1.0],
  );

  static LinearGradient accentGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryColor, accentColor],
  );

  static LinearGradient backgroundGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
    stops: [0.0, 0.5, 1.0],
  );

  static LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surfaceColor.withOpacity(0.9), surfaceColor.withOpacity(0.7)],
  );

  static TextStyle counterTextStyle = TextStyle(
    fontSize: AppConstants.fontSizeExtraLarge,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    letterSpacing: -2.0,
    height: 1.0,
    shadows: [
      Shadow(
        color: Colors.black.withOpacity(0.2),
        offset: const Offset(0, 2),
        blurRadius: 8,
      ),
    ],
  );

  static TextStyle counterLabelStyle = TextStyle(
    fontSize: AppConstants.fontSizeSmall,
    fontWeight: FontWeight.w600,
    color: Colors.white.withOpacity(0.85),
    letterSpacing: 1.2,
    height: 1.4,
  );

  static TextStyle fileContentLabelStyle = TextStyle(
    fontSize: AppConstants.fontSizeMedium,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    letterSpacing: 0.2,
    height: 1.3,
  );

  static TextStyle fileContentStyle = TextStyle(
    fontSize: AppConstants.fontSizeDefault,
    color: textPrimary,
    height: 1.75,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w400,
  );

  static TextStyle buttonTextStyle = const TextStyle(
    fontSize: AppConstants.fontSizeDefault,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    letterSpacing: 0.8,
    height: 1.2,
  );

  static TextStyle emptyFileStyle = TextStyle(
    fontSize: AppConstants.fontSizeDefault,
    color: textTertiary,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static BoxDecoration cardDecoration = BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
    boxShadow: [
      BoxShadow(
        color: primaryColor.withOpacity(0.25),
        blurRadius: 20,
        offset: const Offset(0, 8),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: primaryDark.withOpacity(0.15),
        blurRadius: 40,
        offset: const Offset(0, 16),
        spreadRadius: -4,
      ),
    ],
  );

  static BoxDecoration fileContentContainerDecoration = BoxDecoration(
    color: surfaceColor,
    borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
    border: Border.all(color: borderColor, width: 1.5),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.04),
        blurRadius: 12,
        offset: const Offset(0, 4),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.02),
        blurRadius: 24,
        offset: const Offset(0, 8),
        spreadRadius: -2,
      ),
    ],
  );

  static BoxDecoration gradientButtonDecoration = BoxDecoration(
    gradient: primaryGradient,
    borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
    boxShadow: [
      BoxShadow(
        color: primaryColor.withOpacity(0.35),
        blurRadius: 16,
        offset: const Offset(0, 8),
        spreadRadius: -2,
      ),
      BoxShadow(
        color: primaryDark.withOpacity(0.2),
        blurRadius: 32,
        offset: const Offset(0, 16),
        spreadRadius: -8,
      ),
    ],
  );

  static BoxDecoration glassCardDecoration = BoxDecoration(
    gradient: glassGradient,
    borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
    border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  );
}
