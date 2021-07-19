import 'package:flutter/material.dart';

typedef WidgetCallback<T> = Widget Function(Observer<T>);

extension ObExtension<T> on T {
  Observer<T> get ob => Observer<T>(this);
}

class Observer<T> with ChangeNotifier {

  Observer(this._value);

  T? _value;

  T? get value => _value;

  set value(T? value) {
    resetValue(value);
    notifyListeners();
  }

  void resetValue(T? value) {
    if (_value == value) {
      return;
    }
    _value = value;
  }

  T? call([T? v]) {
    if (v != null) {
      value = v;
    }
    return _value;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(dynamic other) {
    if (other is T) return value == other;
    if (other is Observer<T>) return value == other.value;
    return false;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => _value.hashCode;
}

class ObWidget<T> extends StatefulWidget {
  const ObWidget({required this.builder, required this.initialValue});

  final Observer<T> initialValue;
  final WidgetCallback<T> builder;

  Widget _buildWidget(dynamic data) {
    return builder(data as Observer<T>);
  }

  @override
  State<StatefulWidget> createState() => _ObsWidgetState<T>();
}

class _ObsWidgetState<T> extends State<ObWidget<T>> {

  Observer<T>? _data;

  @override
  void initState() {
    super.initState();
    _data = widget.initialValue;
    _data!.addListener(_rebuild);
  }

  @override
  void dispose() {
    _data!.removeListener(_rebuild);
    _data = null;
    super.dispose();
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => widget._buildWidget(_data!);
}