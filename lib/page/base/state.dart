import 'package:flutter/material.dart';
import 'package:tencent_video/page/manager/boot_manager.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  BootContext? _bootContext;

  BootContext get bootContext => _bootContext!;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bootContext = BootContext.of(context);
    assert(bootContext != null);
    final oldBootContext = _bootContext;
    _bootContext = bootContext;

    if (oldBootContext == null) {
      _updateBootContext(oldBootContext);
    } else if (oldBootContext != bootContext) {
      setState(() {
        _updateBootContext(oldBootContext);
      });
    }
  }

  void changedPage() {}

  void changedThemeStyle() {}

  void updateBootContext(BootContext? oldBootContext) {}

  bool isPage(PageCategory page) {
    return bootContext.isPage(page);
  }

  void _updateBootContext(BootContext? oldBootContext) {

    oldBootContext?.page.removeListener(changedPage);
    oldBootContext?.themeStyle.removeListener(changedThemeStyle);

    bootContext.page.addListener(changedPage);
    bootContext.themeStyle.addListener(changedThemeStyle);

    updateBootContext(oldBootContext);
  }

  @override
  void dispose() {
    bootContext.page.removeListener(changedPage);
    bootContext.themeStyle.removeListener(changedThemeStyle);
    _bootContext = null;
    super.dispose();
  }

}