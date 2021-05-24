import 'package:flutter/material.dart';
import 'package:tencent_video/common/listener/obs.dart';
import 'package:tencent_video/page/state/attr.dart';

enum PageCategory {
  home,
  doki,
  vip,
  message,
  person,
}

abstract class BootContext {

  Obs<PageCategory> get page;
  Obs<NavigationBarAttr> get bottomNavigationBar;
  void changeNavigationBar(NavigationBarAttr value);

  static BootContext? of(BuildContext context) {
    final _BootContextScope? bootContextScope =
        context.dependOnInheritedWidgetOfExactType<_BootContextScope>();
    return bootContextScope?.bootContext;
  }

}

mixin BootManager implements BootContext {

  Obs<PageCategory> _page = PageCategory.home.obs;

  Obs<NavigationBarAttr> _bottomNavigationBar = Attrs.defNavigationBarAttr.obs;

  @override
  Obs<PageCategory> get page => _page;

  @override
  Obs<NavigationBarAttr> get bottomNavigationBar => _bottomNavigationBar;

  Widget startBoot({required Widget child}) {
    return _BootContextScope(
      bootContext: this,
      child: child,
    );
  }

  @override
  void changeNavigationBar(NavigationBarAttr value) {
    if (_bottomNavigationBar.value == value) return;

    _bottomNavigationBar.value = value;
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
