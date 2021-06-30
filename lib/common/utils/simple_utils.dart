import 'package:flutter/material.dart';

class SimpleUtils {
  static Locale getLocalByCode(String code) {
    return Locale.fromSubtags(languageCode: code);
  }
}
