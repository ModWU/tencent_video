import 'package:flutter/material.dart';

class Attrs {
  Attrs._();

  static const NavigationBarAttr defNavigationBarAttr = NavigationBarAttr(backgroundColor: Colors.white, selectedItemColor: Colors.red, unselectedItemColor: Colors.black);

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
