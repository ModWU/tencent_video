import 'package:flutter/material.dart';
import 'boot_manager.dart';

@optionalTypeArgs
mixin BootMiXin<T extends StatefulWidget> on State<T> {

  BootContext get bootContext => BootContext.get();

  @protected
  void changedPage() {}

  @protected
  void changedThemeStyle() {}

  bool isPageAt(PageCategory page) {
    return bootContext.isPageAt(page);
  }

  @override
  void initState() {
    super.initState();

    bootContext.page.addListener(changedPage);
    bootContext.themeStyle.addListener(changedThemeStyle);
  }

  @override
  void dispose() {
    bootContext.page.removeListener(changedPage);
    bootContext.themeStyle.removeListener(changedThemeStyle);
    super.dispose();
  }
}
