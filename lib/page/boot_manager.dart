import 'package:flutter/material.dart';
import 'package:tencent_video/common/listener/ob.dart';
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
  ThemeData get themeData;
  TextStyle get bodyText;
  Ob<ThemeStyle> get themeStyle;
  bool isPage(PageCategory page);
  void changeThemeStyle(ThemeStyle value);

  static BootContext? of(BuildContext context) {
    final _BootContextScope? bootContextScope =
        context.dependOnInheritedWidgetOfExactType<_BootContextScope>();
    return bootContextScope?.bootContext;
  }

}

mixin BootManager implements BootContext {

  Ob<PageCategory> _page = PageCategory.home.ob;

  ThemeData _themeData = ThemeAttrs.get(ThemeStyle.normal);

  ThemeData get themeData => _themeData;

  TextStyle get bodyText => _themeData.textTheme.bodyText1!;

  Ob<ThemeStyle> _themeStyle = ThemeStyle.normal.ob;

  @override
  bool isPage(PageCategory page) {
    return page == _page.value;
  }

  @override
  Ob<PageCategory> get page => _page;

  @override
  Ob<ThemeStyle> get themeStyle => _themeStyle;

  Widget startBoot({required Widget child}) {
    return _BootContextScope(
      bootContext: this,
      child: child,
    );
  }

  @override
  void changeThemeStyle(ThemeStyle value) {
    if (_themeStyle.value == value) return;

    _themeData = ThemeAttrs.get(value);
    _themeStyle.value = value;
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
