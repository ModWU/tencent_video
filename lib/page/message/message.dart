import 'package:flutter/material.dart';
import 'package:tencent_video/resource/styles.dart';
import '../app_state.dart';
import '../base.dart';

class MessagePage extends StatefulWidget {

  MessagePage();

  @override
  State<StatefulWidget> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with BootMiXin {
  @override
  Widget build(BuildContext context) {
    //ScrollablePositionedList.builder(
    //             itemCount: 500,
    //             itemBuilder: (context, index) => Text('Item $index'),
    //             itemScrollController: itemScrollController,
    //             itemPositionsListener: itemPositionsListener,
    //           ),
    return Scaffold(
      appBar: AppBar(title: const Text("title: message",),),
      body: DefaultTextStyle(
        style: bootContext.bodyText,
        child: const Center(
          child: Text("message",),
        ),
      ),
    );
  }

  @override
  void pageChanged() {
    if (isPageAt(PageCategory.message)) {
      bootContext.changeThemeStyle(ThemeStyle.light);
    }
  }
}