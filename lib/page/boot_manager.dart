import 'package:flutter/material.dart';
import 'package:tencent_video/common/listener/ob.dart';
import 'package:tencent_video/resources/languages.dart';
import 'package:tencent_video/generated/l10n.dart';
import 'package:tencent_video/resources/styles.dart';

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

  static BootContext? of(BuildContext context) {
    final _BootContextScope? bootContextScope =
        context.dependOnInheritedWidgetOfExactType<_BootContextScope>();
    return bootContextScope?.bootContext;
  }
}

mixin BootManager implements BootContext {
  final Ob<PageCategory> _page = PageCategory.home.ob;

  final Ob<ThemeStyle> _themeStyle = ThemeStyle.normal.ob;

  final Ob<Locale> _locale = const Locale.fromSubtags(languageCode: LanguageCodes.en).ob;

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

  Widget startBoot({required Widget child}) {
    return _BootContextScope(
      bootContext: this,
      child: RootRestorationScope(
        restorationId: 'root',
        child: child,
      ),
    );
  }

  @override
  void changeThemeStyle(ThemeStyle value) {
    _themeStyle.value = value;
  }

  @override
  void changeLanguage(String? value) {
    final Locale? locale =
        value != null ? Locale.fromSubtags(languageCode: value) : null;
    _locale.value = locale;
  }
}

class _BootContextScope extends InheritedWidget {
  const _BootContextScope({
    Key? key,
    required this.bootContext,
    required Widget child,
  }) : super(key: key, child: child);

  final BootContext bootContext;

  @override
  bool updateShouldNotify(_BootContextScope old) {
    return bootContext != old.bootContext;
  }
}
