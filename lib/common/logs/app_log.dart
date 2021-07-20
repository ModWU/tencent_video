import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tencent_video/common/utils/time_utils.dart';

import 'color_log.dart';

class Logger {
  Logger._();

  static final ColorLogger colorLogger = ColorLogger();

  static void _showErrorTip(String error) {
    colorLogger.custom(decorateLog(error),
        foreColor: 1, backColor: 0, tag: 'E', isDelegateZone: false);
  }

  static void _showErrorSubTip(String error) {
    colorLogger.custom(error, foreColor: 1, tag: 'T', isDelegateZone: false);
  }

  static void _printError(String error) {
    Zone.root.print(error);
  }

  static void reportDartError(Object error, StackTrace stack) {
    _showErrorTip('error#dart: ');
    _showErrorSubTip('error: ');
    _printError('$error');
    _showErrorSubTip('stack: ');
    _printError('$stack');
  }

  static void reportFlutterError(FlutterErrorDetails details) {
    _showErrorTip('error#flutter => details: ');
    _printError('$details');
  }

  static void reportWidgetError(FlutterErrorDetails details) {
    _showErrorTip('error#widget => details: ');
    _printError('$details');
  }

  static String decorateLog(String message) {
    final String time = colorLogger
        .setColor('[${TimeUtils.getStandardNowTime()}]', foreColor: 47);
    return '$time$message';
  }
}
