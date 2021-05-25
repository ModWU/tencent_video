import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tencent_video/page/attr/static_attr.dart';
import 'package:tencent_video/page/boot.dart';
import 'generated/l10n.dart';

void main() {
  runApp(TencentVideoApp());

  SystemUiOverlayStyle style = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  );
  SystemChrome.setSystemUIOverlayStyle(style);
}

class TencentVideoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData localTheme = Theme.of(context);
    return MaterialApp(
      localizationsDelegates: [
        ...GlobalMaterialLocalizations.delegates,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeListResolutionCallback:
          (List<Locale>? locales, Iterable<Locale> supportedLocales) {
        if (locales != null && locales.isNotEmpty) {
          for (Locale locale in locales) {
            if (S.delegate.isSupported(locale)) return locale;
          }
        }
        return S.delegate.supportedLocales[0];
      },
      theme: localTheme.copyWith(),
      home: Boot(),
    );
  }
}
