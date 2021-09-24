import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class TextAttrs {
  const TextAttrs._();

  static const TextStyle home_light_body = TextStyle(
    color: Colors.black,
    fontSize: 14.6,
  );

  static const TextStyle home_light_headline6 = TextStyle(
    color: Colors.black,
    fontSize: 15.8,
  );

  static const TextStyle home_dark_body = TextStyle(
    color: Colors.white,
    fontSize: 14.6,
  );

  static const TextStyle home_dark_headline6 = TextStyle(
    color: Colors.white,
    fontSize: 15.8,
  );
}

enum ThemeStyle {
  normal,
  light,
  dark,
}

class ThemeAttrs {
  const ThemeAttrs._();

  static final ThemeData defaultThemeStyle = ThemeData(
    backgroundColor: ColorAttrs.lightBackgroundColor,
    scaffoldBackgroundColor: ColorAttrs.lightBackgroundColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorAttrs.lightBackgroundColor,
      selectedItemColor: ColorAttrs.home_nav_selected_light_color,
      unselectedItemColor: ColorAttrs.home_nav_unselected_light_color,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 4,
      selectedLabelStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
      ),
      selectedIconTheme: IconThemeData(
        size: 20,
      ),
      unselectedIconTheme: IconThemeData(
        size: 20,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: ColorAttrs.home_tab_unselected_light_color,
      labelColor: ColorAttrs.home_tab_selected_light_color,
      labelPadding: EdgeInsets.symmetric(horizontal: 9.4),
      labelStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: const AppBarTheme(
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
        bodyText1: TextAttrs.home_light_body,
        headline6: TextAttrs.home_light_headline6,
      ),
    ),
  );

  static ThemeData get(ThemeStyle style) {
    final ThemeData defaultThemeData = defaultThemeStyle;
    switch (style) {
      case ThemeStyle.light:
        return defaultThemeData;

      case ThemeStyle.dark:
        return defaultThemeData.copyWith(
          backgroundColor: ColorAttrs.darkBackgroundColor,
          scaffoldBackgroundColor: ColorAttrs.darkBackgroundColor,
          tabBarTheme: defaultThemeData.tabBarTheme.copyWith(
            labelColor: ColorAttrs.home_tab_selected_dark_color,
            unselectedLabelColor: ColorAttrs.home_tab_unselected_dark_color,
          ),
          bottomNavigationBarTheme:
              defaultThemeData.bottomNavigationBarTheme.copyWith(
            backgroundColor: ColorAttrs.darkBackgroundColor,
            selectedItemColor: ColorAttrs.home_nav_selected_dark_color,
            unselectedItemColor: ColorAttrs.home_nav_unselected_dark_color,
          ),
          appBarTheme: defaultThemeData.appBarTheme.copyWith(
            backgroundColor: ColorAttrs.darkBackgroundColor,
            brightness: Brightness.dark,
            titleTextStyle: const TextStyle(
              color: Colors.white,
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          switchTheme: SwitchThemeData(
            trackColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.redAccent[100];
              }
              return Colors.white70;
            }),
            thumbColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.redAccent[400];
              }
              return Colors.black54;
            }),
          ),
          textTheme: const TextTheme(
            bodyText1: TextAttrs.home_dark_body,
            headline6: TextAttrs.home_light_headline6,
          ),
        );

      case ThemeStyle.normal:
      default:
        return defaultThemeData;
    }
  }
}

class SystemUiOverlayAttrs {
  const SystemUiOverlayAttrs._();

  static const SystemUiOverlayStyle light = SystemUiOverlayStyle(
    systemNavigationBarColor: ColorAttrs.systemNavigationBarColor,
    systemNavigationBarDividerColor: null,
    statusBarColor: null,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );

  static const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
    systemNavigationBarColor: ColorAttrs.systemNavigationBarColor,
    systemNavigationBarDividerColor: null,
    statusBarColor: null,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
}
