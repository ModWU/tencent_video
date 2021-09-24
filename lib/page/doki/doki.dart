import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tencent_video/common/log/app_log.dart';
import 'package:tencent_video/resource/styles.dart';
import '../app_state.dart';
import '../base.dart';
import 'video_test.dart';

class DokiPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _DokiPageState();
}

class _DokiPageState extends State<DokiPage> with BootMiXin {
  @override
  Widget build(BuildContext context) {
    Logger.log("doki build");
    final ThemeData localTheme = Theme.of(context);
    return VideoTest();
  }

  @override
  void pageChanged() {
    if (isPageAt(PageCategory.doki)) {
      bootContext.changeThemeStyle(ThemeStyle.light);
    }
  }
}