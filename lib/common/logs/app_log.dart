import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tencent_video/common/utils/time_utils.dart';
import 'color_log.dart';

class Logger {
  Logger._();

  static bool get isDebugMode {
    return kDebugMode;
  }

  static void reportDartError(Object error, StackTrace stack) {
    if (isDebugMode) {
      _print(_colorNowTime(hasError: true)
          .build('dart_error: ', foreColor: ColorType.red));
      _print(ColorLogger.builder.build('error: ', foreColor: ColorType.red));
      _print('$error');
      _print(ColorLogger.builder.build('stack: ', foreColor: ColorType.red));
      _print('$stack');
    } else {}
  }

  static void reportFlutterError(FlutterErrorDetails details) {
    if (isDebugMode) {
      _print(_colorNowTime(hasError: true)
          .build('flutter_error: ', foreColor: ColorType.red));
      _print(ColorLogger.builder.build('details: ', foreColor: ColorType.red));
      _print('$details');
    } else {}
  }

  static void reportWidgetError(FlutterErrorDetails details) {
    if (isDebugMode) {
      _print(_colorNowTime(hasError: true)
          .build('widget_error: ', foreColor: ColorType.red));
      _print(ColorLogger.builder.build('details: ', foreColor: ColorType.red));
      _print('$details');
    } else {}
  }

  static void logByZoneDelegate(
      Zone self, ZoneDelegate parent, Zone zone, String message) {
    log(message);
  }

  static void log(Object object) {
    if (kDebugMode) {
      _print(_colorNowTime().build(object));
    } else {}
  }
}

IColorBuilder _colorNowTime({bool hasError = false}) {
  return ColorLogger.builder.build('[${TimeUtils.getStandardNowTime()}]',
      foreColor: hasError ? ColorType.red : ColorType.darkGreen);
}

void _print(Object object) {
  Zone.root.print('$object');
}
