import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:tencent_video/ui/paint/model/ball_point.dart';

import '../text_3d_ball.dart';

const String _kDefaultData = 'Hello';
const int _kDefaultRow = 3;
const int _kDefaultColumn = 5;
const int _kLoop = 1;
const Color _kDefaultColor = Colors.black;

const TextStyle _kDefaultStyle = TextStyle(
  fontSize: 16,
  color: Colors.white,
);
const TextStyle _kDefaultSecondaryStyle = TextStyle(
  fontSize: 14,
  color: Colors.yellow,
);

class Text3DBallWidget extends StatefulWidget {
  const Text3DBallWidget({
    Key? key,
    this.data = _kDefaultData,
    String? secondaryData,
    this.style = _kDefaultStyle,
    this.secondaryStyle = _kDefaultSecondaryStyle,
    this.row = _kDefaultRow,
    this.column = _kDefaultColumn,
    this.loop = _kLoop,
    this.radius,
    this.color = _kDefaultColor,
  })  : assert(radius == null || radius > 0),
        assert(loop >= 0),
        assert(row >= 0),
        assert(column >= 0),
        secondaryData = secondaryData ?? data,
        super(key: key);

  final String data;
  final String secondaryData;
  final TextStyle style;
  final TextStyle secondaryStyle;
  final int row;
  final int column;
  final int loop;
  final double? radius;
  final Color color;

  @override
  State<StatefulWidget> createState() => _Text3DBallState();
}

class _Text3DBallState extends State<Text3DBallWidget> {
  double? _radius;
  double get radius => _radius!;

  List<BallPoint>? _allPoint;

  ui.Paragraph _buildText(
    String text,
    double aAngle,
    double maxWidth,
    TextStyle style,
  ) {
    final ui.ParagraphBuilder paragraphBuilder =
        ui.ParagraphBuilder(ui.ParagraphStyle());
    final Color? color = style.color;
    final Paint paint = style.foreground ?? Paint()
      ..color = (aAngle >= 0 && aAngle <= pi/ 2) || (aAngle >= 3*pi/2 && aAngle <= 2 * pi) ? color! : color!.withOpacity(0.5);
    /*paint.shader =
        ui.Gradient.linear(const Offset(0, 20), const Offset(150, 20), <Color>[
      paint.color,
      paint.color.withOpacity(0.5),
    ]);*/
    paragraphBuilder.pushStyle(style
        .copyWith(
          color: null,
          foreground: paint,
        )
        .getTextStyle());
    paragraphBuilder.addText(text);

    final ui.Paragraph paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: maxWidth));
    return paragraph;
  }

  void _updatePositions() {
    final double elevation = pi / (widget.row + 1);
    final double azimuth = 2 * pi / (widget.column + 1);

    _allPoint ??= <BallPoint>[];
    _allPoint!.clear();

    for (int e = 0; e < widget.row; e++) {
      //仰角
      final double eAngle = elevation * (e + 1);

      //每个仰角对应圆的周长 -pi/2 -- pi/2
      final double perimeter = (2 * pi * radius * cos(eAngle - pi / 2)).abs();

      ui.Paragraph? paragraph, opacityParagraph;

      for (int a = 0; a < widget.column; a++) {
        //极坐标方位角
        final double aAngle = azimuth * (a + 1);

        //球极坐标转为直角坐标
        final double x = radius * sin(eAngle) * sin(aAngle);
        final double y = radius * cos(eAngle);
        final double z = radius * sin(eAngle) * cos(aAngle);

        final BallPoint point = BallPoint(x, y, z, eAngle, aAngle,
            _buildText(widget.data, aAngle, perimeter, widget.style));
        _allPoint!.add(point);
      }
    }
  }

  bool _needUpdatePositions(Text3DBallWidget oldWidget) {
    return widget.data != oldWidget.data ||
        widget.radius != oldWidget.radius ||
        widget.row != oldWidget.row ||
        widget.column != oldWidget.column ||
        widget.style != oldWidget.style ||
        widget.secondaryStyle != oldWidget.secondaryStyle;
  }

  @override
  void didUpdateWidget(covariant Text3DBallWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_needUpdatePositions(oldWidget)) {
      _updatePositions();
    }
  }

  //半径改变需要重新初始化
  void _initData() {
    _updatePositions();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double maxRadius =
          min(constraints.maxHeight, constraints.maxWidth) * 0.5;
      final double? oldRadius = _radius;
      _radius = widget.radius?.clamp(0, maxRadius) ?? maxRadius;

      if (oldRadius != _radius) {
        _initData();
      }

      return CustomPaint(
        size: Size.fromRadius(_radius!),
        painter: Text3DBallPainter(points: _allPoint, color: widget.color),
      );
    });
  }
}
