import 'dart:io';

import 'package:flutter/material.dart';

extension ObsExtension<T> on T {
  Obs<T> get obs => Obs<T>(this);
}

class Obs<T> with ChangeNotifier {

  T? _value;

  Obs(this._value);

  T? get value => _value;

  set value(T? value) {
    if (_value == value) {
      return;
    }
    _value = value;
    notifyListeners();
  }

}