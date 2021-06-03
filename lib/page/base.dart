import 'package:flutter/material.dart';

import 'boot_manager.dart';

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

  @protected
  void changedPage() {}

  @protected
  void changedThemeStyle() {}

  @protected
  void updateBootContext(BootContext? oldBootContext) {}

  bool isPageAt(PageCategory page) {
    return bootContext.isPageAt(page);
  }

  void _removeListeners(BootContext? bootContext) {
    bootContext?.page.removeListener(changedPage);
    bootContext?.themeStyle.removeListener(changedThemeStyle);
  }

  void _updateBootContext(BootContext? oldBootContext) {
    _removeListeners(oldBootContext);

    bootContext.page.addListener(changedPage);
    bootContext.themeStyle.addListener(changedThemeStyle);

    updateBootContext(oldBootContext);
  }

  @override
  void dispose() {
    assert(_bootContext != null);
    _removeListeners(_bootContext);
    _bootContext = null;
    super.dispose();
  }
}
