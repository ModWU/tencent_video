import 'package:flutter/material.dart';
import 'package:tencent_video/ui/widget/base_video.dart';
import 'dart:math';
class VideoTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoTestState();
}

class _VideoTestState extends State<VideoTest> {

  String asset = "assets/Butterfly-209.mp4";
  String network = "http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4";

  bool isAsset = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          color: Colors.blueGrey.withOpacity(0.5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                isAsset ? VideoWidget.asset(asset) : VideoWidget.network(network),
                Padding(padding: EdgeInsets.only(top: 20)),
                TextButton(child: Text("改变asset"), onPressed: () {
                  final String newAsset = Random().nextDouble() >= 0.5 ? "assets/Butterfly-209.mp4":"assets/a2.mp4";
                  final oldAsset = asset;
                  asset = newAsset;
                  isAsset = true;
                  print("newAsset: $newAsset, oldAsset: $oldAsset");
                  setState(() {

                  });

                },),
                TextButton(child: Text("改变network"), onPressed: () {
                  final String newNetwork = Random().nextDouble() >= 0.5 ? "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4":"http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4";
                  final oldNetwork = network;
                  network = newNetwork;
                  isAsset = false;
                  print("network: $network, oldNetwork: $oldNetwork");
                  setState(() {

                  });
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }

}