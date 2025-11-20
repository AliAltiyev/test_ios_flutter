import 'package:flutter/material.dart';
import '../constants/constants.dart';

class AppStyles {
  AppStyles._();

  static const TextStyle counterTextStyle = TextStyle(
    fontSize: AppConstants.fontSizeLarge,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle fileContentLabelStyle = TextStyle(
    fontSize: AppConstants.fontSizeMedium,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle fileContentStyle = TextStyle(
    fontSize: AppConstants.fontSizeDefault,
  );

  static BoxDecoration fileContentContainerDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
  );
}
