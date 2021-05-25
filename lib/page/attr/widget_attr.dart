import 'package:flutter/material.dart';
import 'package:tencent_video/page/attr/static_attr.dart';

class WidgetAttrs {
  WidgetAttrs._();

  static const NavigationBarAttr defNavigationBarAttr = NavigationBarAttr(backgroundColor: Colors.white, selectedItemColor: Colors.red, unselectedItemColor: Colors.black);

  static const StatusBarAttr lightStatusBarAttr = StatusBarAttr(backgroundColor: ColorAttrs.lightBackgroundColor, brightness: Brightness.light);
  static const StatusBarAttr darkStatusBarAttr = StatusBarAttr(backgroundColor: ColorAttrs.darkBackgroundColor, brightness: Brightness.dark);


}

class StatusBarAttr {
  final Color backgroundColor;
  final Brightness brightness;

  const StatusBarAttr({
    required this.backgroundColor,
    required this.brightness,
  });

  StatusBarAttr copyWith({
    Color? backgroundColor,
    Brightness? brightness,
  }) {
    return StatusBarAttr(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      brightness: brightness ?? this.brightness,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is StatusBarAttr &&
        other.backgroundColor == backgroundColor &&
        other.brightness == brightness;
  }

  @override
  int get hashCode {
    return hashValues(
      backgroundColor,
      brightness,
    );
  }

  @override
  String toString() =>
      "StatusBarAttr(backgroundColor: $backgroundColor, brightness: $brightness)";
}

class NavigationBarAttr {
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;

  const NavigationBarAttr({
    required this.backgroundColor,
    required this.selectedItemColor,
    required this.unselectedItemColor,
  });

  NavigationBarAttr copyWith({
    Color? backgroundColor,
    Color? selectedItemColor,
    Color? unselectedItemColor,
  }) {
    return NavigationBarAttr(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedItemColor: selectedItemColor ?? this.selectedItemColor,
      unselectedItemColor: unselectedItemColor ?? this.unselectedItemColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is NavigationBarAttr &&
        other.backgroundColor == backgroundColor &&
        other.selectedItemColor == selectedItemColor &&
        other.unselectedItemColor == unselectedItemColor;
  }

  @override
  int get hashCode {
    return hashValues(
      backgroundColor,
      selectedItemColor,
      unselectedItemColor,
    );
  }

  @override
  String toString() =>
      "NavigationBarAttr(backgroundColor: $backgroundColor, selectedItemColor: $selectedItemColor, unselectedItemColor: $unselectedItemColor)";
}
