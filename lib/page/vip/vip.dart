import 'package:flutter/material.dart';
import 'package:tencent_video/resources/styles.dart';
import '../base.dart';
import '../boot_manager.dart';

class VipPage extends StatefulWidget {

  VipPage();

  @override
  State<StatefulWidget> createState() => _VipPageState();
}

class _VipPageState extends BaseState<VipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("title: vip",),),
      body: DefaultTextStyle(
        style: bootContext.bodyText,
        child: const Center(
          child: Text("vip",),
        ),
      ),
    );;
  }

  @override
  void changedPage() {
    if (isPageAt(PageCategory.vip)) {
      bootContext.changeThemeStyle(ThemeStyle.light);
    }
  }
}