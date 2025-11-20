class AppConstants {
  AppConstants._();

  static const String nativeChannelName = 'com.example.test_ios_flutter/native';

  static const String methodWriteToFile = 'writeToFile';
  static const String methodReadFile = 'readFile';

  static const String paramCounter = 'counter';

  static const String uiAppTitle = 'Flutter iOS Native Bridge';
  static const String uiCounterLabel = 'Счётчик:';
  static const String uiButtonText = 'Увеличить счётчик и записать в файл';
  static const String uiFileContentLabel = 'Содержимое файла:';
  static const String uiEmptyFile = 'Файл пуст';
  static const String uiErrorPrefix = 'Ошибка:';
  static const String uiReadErrorPrefix = 'Ошибка чтения:';

  static const double paddingDefault = 16.0;
  static const double spacingLarge = 32.0;
  static const double spacingMedium = 16.0;
  static const double borderRadius = 8.0;

  static const double fontSizeLarge = 24.0;
  static const double fontSizeMedium = 18.0;
  static const double fontSizeDefault = 16.0;
}
