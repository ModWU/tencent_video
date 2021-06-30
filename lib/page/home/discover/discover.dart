import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:tencent_video/ui/paint/text_3d_ball.dart';
import 'package:tencent_video/ui/paint/widget/text_3d_ball_widget.dart';

class Discover extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: Colors.grey.withOpacity(0.4),
                width: 350,
                height: 350,
                child: const Text3DBallWidget(
                  color: Colors.black,
                  row: 4,
                  column: 6,
                  style: TextStyle(fontSize: 24, color: Colors.yellow),
                ),
              ),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
                    tileMode: TileMode.clamp,
                  ).createShader(bounds);
                },
                child: const Text('I’m burning the memories'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
