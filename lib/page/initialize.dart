import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tencent_video/common/logs/app_log.dart';
import 'package:tencent_video/page/app_state.dart';

typedef Runner = void Function();

void startBoot(Widget root) {
  _runOnLogger(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await AppState.initialize();
    runApp(root);
  });
}

String _stringify(Object? exception) {
  try {
    return exception.toString();
  } catch (e) {
    // intentionally left empty.
  }
  return 'Error';
}

void _runOnLogger(Runner runner) {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    Logger.reportWidgetError(details);
    String message = '';
    assert(() {
      message =
          '${_stringify(details.exception)}\nSee also: https://flutter.dev/docs/testing/errors';
      return true;
    }());
    final Object exception = details.exception;
    return ErrorWidget.withDetails(
        message: message, error: exception is FlutterError ? exception : null);
  };
  FlutterError.onError = (FlutterErrorDetails details) {
    Logger.reportFlutterError(details);
  };
  runZonedGuarded<Future<void>>(
    () async {
      runner();
    },
    (Object error, StackTrace stack) {
      Logger.reportDartError(error, stack);
    },
    zoneValues: <String, String>{'name': 'app'},
    zoneSpecification: ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
      parent.print(zone, Logger.decorateLog(line));
    }),
  );
}
