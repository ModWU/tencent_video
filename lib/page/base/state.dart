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
      updateBootContext(oldBootContext);
    } else if (oldBootContext != bootContext) {
      setState(() {
        updateBootContext(oldBootContext);
      });
    }
  }

 void updateBootContext(BootContext? oldBootContext) {}

  @override
  void dispose() {
    _bootContext = null;
    super.dispose();
  }

}