import 'package:flutter/material.dart';
import 'package:tencent_video/resources/styles.dart';
import '../boot_manager.dart';
import '../base.dart';

class DokiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DokiPageState();
}

class _DokiPageState extends BaseState<DokiPage> {
  @override
  Widget build(BuildContext context) {
    print("doki build");
    final ThemeData localTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("title: doki",),),
      body: DefaultTextStyle(
        style: bootContext.bodyText,
        child: Center(
          child: Text("doki",),
        ),
      ),
    );
  }

  @override
  void changedPage() {
    if (isPage(PageCategory.doki)) {
      bootContext.changeThemeStyle(ThemeStyle.light);
    }
  }
}