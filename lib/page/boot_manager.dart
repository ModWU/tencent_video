import 'package:flutter/material.dart';
import 'package:tencent_video/common/listener/ob.dart';
import 'package:tencent_video/common/utils/simple_utils.dart';
import 'package:tencent_video/resources/strings.dart';
import 'package:tencent_video/resources/styles.dart';
import 'boot.dart';

enum PageCategory {
  home,
  doki,
  vip,
  message,
  person,
}

abstract class BootContext {
  Ob<PageCategory> get page;
  Ob<ThemeStyle> get themeStyle;
  Ob<Locale> get locale;

  void changeThemeStyle(ThemeStyle value);
  void changeLanguage(String? languageCode);

  bool isPageAt(PageCategory page);
  TextStyle get bodyText;
  ThemeData get themeData;

  static BootContext get() {
    return BootManager._instance!;
  }
}

mixin BootManager on State<Boot> implements BootContext {
  final Ob<PageCategory> _page = PageCategory.home.ob;

  final Ob<ThemeStyle> _themeStyle = ThemeStyle.normal.ob;

  final Ob<Locale> _locale = SimpleUtils.getLocalByCode(LanguageCodes.en).ob;

  @override
  bool isPageAt(PageCategory page) {
    return page == _page.value;
  }

  @override
  Ob<PageCategory> get page => _page;

  @override
  Ob<ThemeStyle> get themeStyle => _themeStyle;

  @override
  Ob<Locale> get locale => _locale;

  static BootManager? _instance;

  @override
  void initState() {
    super.initState();
    _instance = this;
  }

  @override
  void dispose() {
    _instance = null;
    super.dispose();
  }

  @override
  void changeThemeStyle(ThemeStyle value) {
    _themeStyle.value = value;
  }

  @override
  void changeLanguage(String? value) {
    final Locale? locale =
        value != null ? SimpleUtils.getLocalByCode(value) : null;
    _locale.value = locale;
  }
}
