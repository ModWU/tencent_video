import 'dart:ui' as ui;
import 'package:flutter/material.dart';

@immutable
class BallPoint {
  const BallPoint(
      this.x, this.y, this.z, this.eAngle, this.aAngle, this.paragraph);

  final double x, y, z;
  final ui.Paragraph paragraph;
  final double aAngle, eAngle;

  @override
  int get hashCode => hashValues(x, y, z, eAngle, aAngle, paragraph);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is BallPoint &&
        other.x == x &&
        other.y == y &&
        other.z == z &&
        other.eAngle == eAngle &&
        other.aAngle == aAngle &&
        other.paragraph == paragraph;
  }
}
