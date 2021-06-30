import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class _ListenerEntry extends LinkedListEntry<_ListenerEntry> {
  _ListenerEntry(this.listener);
  final Function listener;
}

abstract class DataListenable {
  const DataListenable();

  void addListener(dynamic key, Function listener);

  void removeListener(Function listener);

  void removeListenerByKey(dynamic key, Function listener);

  void removeAllListenerByKey(dynamic key);
}

class DataNotifier implements DataListenable {
  HashMap<dynamic, LinkedList<_ListenerEntry>>? _listeners =
      HashMap<dynamic, LinkedList<_ListenerEntry>>();

  bool _debugAssertNotDisposed() {
    assert(() {
      if (_listeners == null) {
        throw FlutterError(
          'A $runtimeType was used after being disposed.\n'
          'Once you have called dispose() on a $runtimeType, it can no longer be used.',
        );
      }
      return true;
    }());
    return true;
  }

  @protected
  bool get hasListeners {
    assert(_debugAssertNotDisposed());
    return _listeners!.isNotEmpty;
  }

  @override
  void addListener(dynamic key, Function listener) {
    assert(_debugAssertNotDisposed());
    LinkedList<_ListenerEntry>? _listenerEntries = _listeners![key];
    _listenerEntries ??= LinkedList<_ListenerEntry>();
    _listenerEntries.add(_ListenerEntry(listener));
    _listeners!.putIfAbsent(key, () => _listenerEntries!);
  }

  @override
  void removeListener(Function listener) {
    assert(_debugAssertNotDisposed());
    for (final MapEntry<dynamic, LinkedList<_ListenerEntry>> mapEntry
        in _listeners!.entries) {
      final dynamic key = mapEntry.key;
      final LinkedList<_ListenerEntry> value = mapEntry.value;
      for (final _ListenerEntry entry in value) {
        if (entry.listener == listener) {
          entry.unlink();
          if (_listeners![key]!.isEmpty) {
            _listeners!.remove(key);
          }
          return;
        }
      }
    }
  }

  @override
  void removeListenerByKey(dynamic key, Function listener) {
    assert(_debugAssertNotDisposed());
    final LinkedList<_ListenerEntry>? _listenerEntries = _listeners![key];
    if (_listenerEntries == null) {
      return;
    }

    for (final _ListenerEntry entry in _listenerEntries) {
      if (entry.listener == listener) {
        entry.unlink();
        if (_listenerEntries.isEmpty) {
          _listeners!.remove(key);
        }
        return;
      }
    }
  }

  @override
  void removeAllListenerByKey(dynamic key) {
    assert(_debugAssertNotDisposed());
    final LinkedList<_ListenerEntry>? _listenerEntries = _listeners![key];
    if (_listenerEntries == null) {
      return;
    }
    _listeners!.remove(key);
  }

  @mustCallSuper
  void dispose() {
    assert(_debugAssertNotDisposed());
    _listeners!.clear();
    _listeners = null;
  }

  @protected
  @visibleForTesting
  void notifyListeners(dynamic key,
      [Object? arg01,
      Object? arg02,
      Object? arg03,
      Object? arg04,
      Object? arg05,
      Object? arg06,
      Object? arg07,
      Object? arg08,
      Object? arg09,
      Object? arg10,
      Object? arg11,
      Object? arg12,
      Object? arg13,
      Object? arg14,
      Object? arg15,
      Object? arg16,
      Object? arg17,
      Object? arg18,
      Object? arg19,
      Object? arg20]) {
    assert(_debugAssertNotDisposed());
    if (_listeners!.isEmpty) return;

    final LinkedList<_ListenerEntry>? _listenerEntries = _listeners![key];
    if (_listenerEntries == null || _listenerEntries.isEmpty) return;

    final List<_ListenerEntry> localListeners =
        List<_ListenerEntry>.from(_listenerEntries);

    for (final _ListenerEntry entry in localListeners) {
      try {
        if (entry.list != null) {
          invoke(
            entry.listener,
            arg01,
            arg02,
            arg03,
            arg04,
            arg05,
            arg06,
            arg07,
            arg08,
            arg09,
            arg10,
            arg11,
            arg12,
            arg13,
            arg14,
            arg15,
            arg15,
            arg17,
            arg18,
            arg19,
            arg20,
          );
        }
      } catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: stack,
          library: 'foundation library',
          context: ErrorDescription(
              'while dispatching notifications for $runtimeType'),
          informationCollector: () sync* {
            yield DiagnosticsProperty<DataNotifier>(
              'The $runtimeType sending notification was',
              this,
              style: DiagnosticsTreeStyle.errorProperty,
            );
          },
        ));
      }
    }
  }
}

void invoke(Function function,
    [Object? arg01,
    Object? arg02,
    Object? arg03,
    Object? arg04,
    Object? arg05,
    Object? arg06,
    Object? arg07,
    Object? arg08,
    Object? arg09,
    Object? arg10,
    Object? arg11,
    Object? arg12,
    Object? arg13,
    Object? arg14,
    Object? arg15,
    Object? arg16,
    Object? arg17,
    Object? arg18,
    Object? arg19,
    Object? arg20]) {
  if (arg01 == null) {
    function();
    return;
  }
  if (arg02 == null) {
    function(arg01);
    return;
  }
  if (arg03 == null) {
    function(arg01, arg02);
    return;
  }
  if (arg04 == null) {
    function(arg01, arg02, arg03);
    return;
  }
  if (arg05 == null) {
    function(arg01, arg02, arg03, arg04);
    return;
  }
  if (arg06 == null) {
    function(arg01, arg02, arg03, arg04, arg05);
    return;
  }
  if (arg07 == null) {
    function(arg01, arg02, arg03, arg04, arg05, arg06);
    return;
  }
  if (arg08 == null) {
    function(arg01, arg02, arg03, arg04, arg05, arg06, arg07);
    return;
  }
  if (arg09 == null) {
    function(arg01, arg02, arg03, arg04, arg05, arg06, arg08);
    return;
  }
  if (arg10 == null) {
    function(arg01, arg02, arg03, arg04, arg05, arg06, arg08, arg09);
    return;
  }
  if (arg11 == null) {
    function(arg01, arg02, arg03, arg04, arg05, arg06, arg08, arg09, arg10);
    return;
  }
  if (arg12 == null) {
    function(
        arg01, arg02, arg03, arg04, arg05, arg06, arg08, arg09, arg10, arg11);
    return;
  }
  if (arg13 == null) {
    function(arg01, arg02, arg03, arg04, arg05, arg06, arg08, arg09, arg10,
        arg11, arg12);
    return;
  }
  if (arg14 == null) {
    function(arg01, arg02, arg03, arg04, arg05, arg06, arg08, arg09, arg10,
        arg11, arg12, arg13);
    return;
  }
  if (arg15 == null) {
    function(arg01, arg02, arg03, arg04, arg05, arg06, arg08, arg09, arg10,
        arg11, arg12, arg13, arg14);
    return;
  }
  if (arg16 == null) {
    function(arg01, arg02, arg03, arg04, arg05, arg06, arg08, arg09, arg10,
        arg11, arg12, arg13, arg14, arg15);
    return;
  }
  if (arg17 == null) {
    function(arg01, arg02, arg03, arg04, arg05, arg06, arg08, arg09, arg10,
        arg11, arg12, arg13, arg14, arg15, arg16);
    return;
  }
  if (arg18 == null) {
    function(arg01, arg02, arg03, arg04, arg05, arg06, arg08, arg09, arg10,
        arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    return;
  }
  if (arg19 == null) {
    function(arg01, arg02, arg03, arg04, arg05, arg06, arg08, arg09, arg10,
        arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
    return;
  }
  if (arg20 == null) {
    function(arg01, arg02, arg03, arg04, arg05, arg06, arg08, arg09, arg10,
        arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
    return;
  }
  function(arg01, arg02, arg03, arg04, arg05, arg06, arg08, arg09, arg10, arg11,
      arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
}
