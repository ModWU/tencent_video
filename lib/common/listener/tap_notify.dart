import 'package:flutter/material.dart';

class TapListener extends ChangeNotifier {
  Object? value;

  TapListener([this.value]);

  void onTap([Object? value]) {
    this.value = value;
    notifyListeners();
  }
}
