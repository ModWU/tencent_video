import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:tencent_video/ui/paint/model/ball_point.dart';

class Text3DBallPainter extends CustomPainter {
  Text3DBallPainter({this.points, this.color = Colors.black})
      : _ballPaint = Paint()
          ..color = color
          ..isAntiAlias = true
          ..style = PaintingStyle.fill;

  final List<BallPoint>? points;

  final Color color;

  final Paint _ballPaint;

  @override
  void paint(Canvas canvas, Size size) {
    if (points?.isNotEmpty != true) {
      return;
    }

    final double radius = min(size.width / 2, size.height / 2);
    final Offset center = Offset(size.width / 2, size.height / 2);

    final RRect clipArea = RRect.fromRectAndRadius(
        Rect.fromCircle(center: center, radius: radius),
        Radius.circular(radius));
    canvas.clipRRect(clipArea);
    //canvas.drawColor(color, BlendMode.color);
    canvas.drawRRect(clipArea, _ballPaint);

    for (int i = 0; i < points!.length; i++) {
      final BallPoint ballPoint = points![i];

      final ui.Paragraph paragraph = ballPoint.paragraph;

      final double x = radius + ballPoint.x,
          y = radius - ballPoint.y,
          z = ballPoint.z;

      final double halfTextWidth = paragraph.minIntrinsicWidth / 2;
      final double halfTextHeight = paragraph.height / 2;

      canvas.save();

      canvas.translate(x + halfTextWidth, y + halfTextHeight);
      //aAgnle: 0-2*pi        rotationY: 0-2*pi
      canvas.transform(Matrix4.rotationY(ballPoint.aAngle).storage);
      //eAgnle: 0-pi        rotationX: 3*pi/2-5*pi/2
      canvas.transform(Matrix4.rotationX(3 * pi / 2 + ballPoint.eAngle).storage);
      canvas.skew(-0.26, 0);
      canvas.drawParagraph(
        ballPoint.paragraph,
        Offset(-paragraph.minIntrinsicWidth, -paragraph.height),
      );


      canvas.restore();

    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
