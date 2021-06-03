import 'package:flutter/material.dart';
import 'package:tencent_video/ui/decoration/triangle_arrow_decoration.dart';

class Subscribe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: TriangleArrowDecoration(
            color: Colors.redAccent[400]!.withOpacity(0.2),
            triangleArrowDirection: TriangleArrowDirection.topRight,
            arrowHeight: 8,
            arrowBreadth: 0.4,
            arrowWidth: 12,
            arrowSmoothness: 0.4,
            borderRadius: BorderRadius.circular(8)),
        height: 100,
        width: 100,
        padding: EdgeInsets.only(top: 8),
        alignment: Alignment.center,
        child: Text("订阅"),
      ),
    );
  }
}
