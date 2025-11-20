import 'package:flutter/services.dart';
import '../constants/constants.dart';

class NativeChannelService {
  NativeChannelService._();

  static final NativeChannelService instance = NativeChannelService._();

  final MethodChannel _channel = const MethodChannel(
    AppConstants.nativeChannelName,
  );

  Future<void> writeToFile(int counter) async {
    try {
      await _channel.invokeMethod(AppConstants.methodWriteToFile, {
        AppConstants.paramCounter: counter,
      });
    } on PlatformException catch (e) {
      throw NativeChannelException(
        code: e.code,
        message: e.message ?? AppConstants.errorUnknownWrite,
        details: e.details,
      );
    }
  }

  Future<String> readFile() async {
    try {
      final String? content = await _channel.invokeMethod(
        AppConstants.methodReadFile,
      );
      return content ?? AppConstants.uiEmptyFile;
    } on PlatformException catch (e) {
      throw NativeChannelException(
        code: e.code,
        message: e.message ?? AppConstants.errorUnknownRead,
        details: e.details,
      );
    }
  }
}

class NativeChannelException implements Exception {
  final String code;
  final String message;
  final dynamic details;

  const NativeChannelException({
    required this.code,
    required this.message,
    this.details,
  });

  @override
  String toString() => AppConstants.exceptionFormat
      .replaceAll('%code%', code)
      .replaceAll('%message%', message);
}
