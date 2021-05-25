import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextAttrs {
  const TextAttrs._();

  static const TextStyle defTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 14.6,
  );

  static const TextStyle defBodyText1 = TextStyle(
    color: Colors.black,
    fontSize: 14.6,
  );

  static const TextStyle defHeadline6 = TextStyle(
    color: Colors.black,
    fontSize: 15.8,
  );
}

enum ThemeStyle {
  normal,
  light,
  dark,
}

class ThemeAttrs {
  ThemeAttrs._();

  static ThemeData _defaultThemeStyle() {
    return ThemeData(
      backgroundColor: ColorAttrs.lightBackgroundColor,
      scaffoldBackgroundColor: ColorAttrs.lightBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorAttrs.lightBackgroundColor,
        brightness: Brightness.light,
        elevation: 0.4,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        textTheme: TextTheme(
          bodyText1: TextAttrs.defBodyText1,
          headline6: TextAttrs.defHeadline6,
        ),
      ),
    );
  }

  static ThemeData get(ThemeStyle style) {
    final ThemeData defaultThemeData = _defaultThemeStyle();
    switch (style) {
      case ThemeStyle.light:
        return defaultThemeData.copyWith(
          backgroundColor: ColorAttrs.lightBackgroundColor,
          scaffoldBackgroundColor: ColorAttrs.lightBackgroundColor,
          appBarTheme: defaultThemeData.appBarTheme.copyWith(
            backgroundColor: ColorAttrs.lightBackgroundColor,
            brightness: Brightness.light,
            titleTextStyle: TextStyle(
              color: Colors.black,
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
          textTheme: TextTheme(
            bodyText1: TextAttrs.defBodyText1.copyWith(
              color: Colors.black,
            ),
            headline6: TextAttrs.defHeadline6.copyWith(
              color: Colors.black,
            ),
          ),
        );

      case ThemeStyle.dark:
        return defaultThemeData.copyWith(
          backgroundColor: ColorAttrs.darkBackgroundColor,
          scaffoldBackgroundColor: ColorAttrs.darkBackgroundColor,
          appBarTheme: defaultThemeData.appBarTheme.copyWith(
            backgroundColor: ColorAttrs.darkBackgroundColor,
            brightness: Brightness.dark,
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          textTheme: TextTheme(
            bodyText1: TextAttrs.defBodyText1.copyWith(
              color: Colors.white,
            ),
            headline6: TextAttrs.defHeadline6.copyWith(
              color: Colors.white,
            ),
          ),
        );

      case ThemeStyle.normal:
      default:
        return defaultThemeData;
    }
  }
}

class ColorAttrs {
  const ColorAttrs._();
  static const Color lightBackgroundColor = Color(0xFFFAFAFA);

  static const Color darkBackgroundColor = Color(0xFF000000);
}
