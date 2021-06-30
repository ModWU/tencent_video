import 'package:flutter/material.dart';

typedef WidgetCallback<T> = Widget Function(Ob<T>);

extension ObExtension<T> on T {
  Ob<T> get ob => Ob<T>(this);
}

class Ob<T> with ChangeNotifier {

  Ob(this._value);

  T? _value;

  T? get value => _value;

  set value(T? value) {
    if (_value == value) {
      return;
    }
    _value = value;
    notifyListeners();
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
    if (other is Ob<T>) return value == other.value;
    return false;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => _value.hashCode;
}

class ObWidget<T> extends StatefulWidget {
  const ObWidget({required this.builder, required this.initialValue});

  final Ob<T> initialValue;
  final WidgetCallback<T> builder;

  Widget _buildWidget(dynamic data) {
    return builder(data as Ob<T>);
  }

  @override
  State<StatefulWidget> createState() => _ObsWidgetState<T>();
}

class _ObsWidgetState<T> extends State<ObWidget<T>> {

  Ob<T>? _data;

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