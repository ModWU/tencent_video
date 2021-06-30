import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tencent_video/page/boot.dart';

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
