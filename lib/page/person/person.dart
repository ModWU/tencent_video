import 'package:flutter/material.dart';
import 'package:tencent_video/resources/styles.dart';
import '../app_state.dart';
import '../base.dart';

class PersonPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> with BootMiXin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("title: person",),),
      body: DefaultTextStyle(
        style: bootContext.bodyText,
        child: const Center(
          child: Text("person",),
        ),
      ),
    );;
  }

  @override
  void pageChanged() {
    if (isPageAt(PageCategory.person)) {
      bootContext.changeThemeStyle(ThemeStyle.light);
    }
  }
}