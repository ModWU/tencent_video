import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tencent_video/resource/colors.dart';
import 'package:tencent_video/resource/styles.dart';

class AppUtils {
  AppUtils._();

  static Locale getLocalByCode(String code) {
    return Locale.fromSubtags(languageCode: code);
  }

  static void setAppSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayAttrs.light,
    );
  }
}
