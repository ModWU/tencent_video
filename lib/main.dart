import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tencent_video/page/boot.dart';
import 'generated/l10n.dart';

void main() {
  runApp(TencentVideoApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class TencentVideoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Boot();
}
