import 'package:flutter/material.dart';

import 'attr/static_attr.dart';
import 'base/state.dart';
import 'manager/boot_manager.dart';

class MessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends BaseState<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("title: message",),),
      body: DefaultTextStyle(
        style: bootContext.bodyText,
        child: Center(
          child: Text("message",),
        ),
      ),
    );
  }

  @override
  void changedPage() {
    if (isPage(PageCategory.message)) {
      bootContext.changeThemeStyle(ThemeStyle.light);
    }
  }
}