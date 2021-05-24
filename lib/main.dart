import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tencent_video/page/boot.dart';
import 'generated/l10n.dart';

void main() {
  runApp(TencentVideoApp());
}

class TencentVideoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      home: Boot(),
    );
  }
}
