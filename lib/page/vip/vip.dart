import 'package:flutter/material.dart';
import 'package:tencent_video/resource/styles.dart';
import '../app_state.dart';
import '../base.dart';

class VipPage extends StatefulWidget {

  VipPage();

  @override
  State<StatefulWidget> createState() => _VipPageState();
}

class _VipPageState extends State<VipPage> with BootMiXin {
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
  void pageChanged() {
    if (isPageAt(PageCategory.vip)) {
      bootContext.changeThemeStyle(ThemeStyle.light);
    }
  }
}