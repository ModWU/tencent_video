import 'dart:io';

import 'package:flutter/material.dart';

typedef WidgetCallback = Widget Function();

extension ObExtension<T> on T {
  Ob<T> get ob => Ob<T>(this);
}

class Ob<T> with ChangeNotifier {

  T? _value;

  Ob(this._value);

  T? get value => _value;

  set value(T? value) {
    if (_value == value) {
      return;
    }
    _value = value;
    notifyListeners();
  }

}

class ObWidget<T> extends StatefulWidget {

  final Ob<T> ob;
  final WidgetCallback builder;

  const ObWidget({required this.ob, required this.builder});

  @override
  State<StatefulWidget> createState() => _ObsWidgetState();
}

class _ObsWidgetState extends State<ObWidget> {

  @override
  void initState() {
    super.initState();
    widget.ob.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.ob.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget.builder();

}