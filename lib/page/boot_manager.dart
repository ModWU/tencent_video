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
  Ob<ThemeStyle> get themeStyle;
  void changeThemeStyle(ThemeStyle value);

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
  Ob<PageCategory> _page = PageCategory.home.ob;

  Ob<ThemeStyle> _themeStyle = ThemeStyle.normal.ob;

  @override
  bool isPageAt(PageCategory page) {
    return page == _page.value;
  }

  @override
  Ob<PageCategory> get page => _page;

  @override
  Ob<ThemeStyle> get themeStyle => _themeStyle;

  Widget startBoot({required Widget child}) {
    return _BootContextScope(
      bootContext: this,
      child: RootRestorationScope(
        restorationId: "root",
        child: child,
      ),
    );
  }

  @override
  void changeThemeStyle(ThemeStyle value) {
    if (_themeStyle.value == value) return;
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
