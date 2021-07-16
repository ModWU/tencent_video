import 'package:flutter/material.dart';
import 'package:tencent_video/common/listener/ob.dart';
import 'package:tencent_video/common/utils/app_utils.dart';
import 'package:tencent_video/resources/styles.dart';
import 'base.dart';
import 'boot.dart';

abstract class BootContext {
  factory BootContext.get() => _BootContextRefManager.bootContextInstance!;

  Observer<PageCategory> get page;
  Observer<ThemeStyle> get themeStyle;
  Observer<Locale> get locale;

  void changeThemeStyle(ThemeStyle value);
  void changeLanguage(String? languageCode);

  Listenable bindListeners(Object key, List<IAppState> states);
  Listenable unbindListeners(Object key);

  bool isPageAt(PageCategory page);
  TextStyle get bodyText;
  ThemeData get themeData;
}

mixin BootManager on State<Boot> implements BootContext {
  @override
  Observer<PageCategory> get page => AppState.page.observer;

  @override
  Observer<ThemeStyle> get themeStyle => AppState.theme.observer;

  @override
  Observer<Locale> get locale => AppState.language.observer;

  @override
  Listenable bindListeners(Object key, List<IAppState> states) =>
      AppState.bindListeners(key, states);

  @override
  Listenable unbindListeners(Object key) => AppState.unbindListeners(key);

  @override
  bool isPageAt(PageCategory pageValue) {
    return pageValue == page.value;
  }

  @override
  void initState() {
    super.initState();
    _BootContextRefManager.addInstance(this);
  }

  @override
  void dispose() {
    if (_BootContextRefManager.removeInstance(this)) {
      _BootContextRefManager.dispose();
    }
    super.dispose();
  }

  @override
  void changeThemeStyle(ThemeStyle value) {
    themeStyle.value = value;
  }

  @override
  void changeLanguage(String? value) {
    final Locale? localeValue =
        value != null ? AppUtils.getLocalByCode(value) : null;
    locale.value = localeValue;
  }
}

class _BootContextRefManager {
  _BootContextRefManager._();

  static BootContext? _bootContextInstance;
  static Map<int, BootContext>? bootContextRefCache;

  static BootContext? get bootContextInstance =>
      bootContextRefCache?[_bootContextInstance?.hashCode];

  static void addInstance(BootContext instance) {
    bootContextRefCache ??= <int, BootContext>{};
    bootContextRefCache![instance.hashCode] = instance;
    _bootContextInstance = instance;
  }

  static bool removeInstance(BootContext instance) {
    bootContextRefCache?.remove(instance.hashCode);
    return bootContextRefCache?.isEmpty ?? true;
  }

  static void dispose() {
    _bootContextInstance = null;
    bootContextRefCache = null;
  }
}
