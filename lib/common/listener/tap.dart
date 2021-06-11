import 'package:flutter/material.dart';

class TapListener extends ChangeNotifier {
  TapListener([this.value]);

  Object? value;

  void onTap([Object? value]) {
    this.value = value;
    notifyListeners();
  }
}
