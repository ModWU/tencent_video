import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tencent_video/resources/colors.dart';
import 'package:tencent_video/resources/styles.dart';

class AppUtils {
  static Locale getLocalByCode(String code) {
    return Locale.fromSubtags(languageCode: code);
  }

  static void setAppSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayAttrs.light,
    );
  }
}
