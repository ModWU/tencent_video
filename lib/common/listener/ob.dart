import 'package:flutter/material.dart';

typedef WidgetCallback<T> = Widget Function(Ob<T>);

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

  T? call([T? v]) {
    if (v != null) {
      value = v;
    }
    return _value;
  }

  @override
  bool operator ==(dynamic o) {
    if (o is T) return value == o;
    if (o is Ob<T>) return value == o.value;
    return false;
  }

  @override
  int get hashCode => _value.hashCode;
}

class ObWidget<T> extends StatefulWidget {
  final Ob<T> initialValue;
  final WidgetCallback<T> builder;

  const ObWidget({required this.builder, required this.initialValue});

  Widget _buildWidget(Ob data) {
    return builder(data as Ob<T>);
  }

  @override
  State<StatefulWidget> createState() => _ObsWidgetState();
}

class _ObsWidgetState extends State<ObWidget> {

  Ob? _data;

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