//display mode: 0(default) 1(highlight) 22(not bold) 4(underline) 24(not underline) 5(flicker) 25(not flicker) 7(reverse show) 27(not reverse show)
//foreground: 30(black) 31(red) 32(green) 33(yellow) 34(blue) 35(carmine) 36(cyan) 37(white)
//background: 40(black) 41(red) 42(green) 43(yellow) 44(blue) 45(carmine) 46(cyan) 47(white)

import 'dart:async';

String _ansiCsi = '\x1b[';
String _defaultColor = '${_ansiCsi}0m';
String _verboseSeq = '${_ansiCsi}38;5;244m';

class ColorType {
  ColorType._();

  static const int white = 0;
  static const int carmine = 1;
  static const int darkYellow = 2;//or 3,10
  static const int blue = 4;//or 12
  static const int purple = 5;
  static const int darkGreen = 6;
  static const int gray = 7;
  static const int darkGray = 8;
  static const int red = 9;
  static const int yellow = 11;
  static const int pink = 13;
  static const int green = 47;//14
}

abstract class IColorBuilder {
  IColorBuilder build(
    Object object, {
    int? foreColor,
    int? backColor,
  });

  String string();
}

class _ColorBuilder implements IColorBuilder {
  _ColorBuilder._();

  final StringBuffer _buffer = StringBuffer();

  @override
  IColorBuilder build(
    Object object, {
    int? foreColor,
    int? backColor,
  }) {
    String foreTag = '38';
    if (foreColor == null) {
      foreTag = '39';
    }

    final String backData =
        backColor == null ? '' : '${_ansiCsi}48;5;${backColor}m';

    final String data =
        '$_ansiCsi$foreTag;5;${foreColor ?? '0'}m$backData$object$_defaultColor';
    _buffer.write(data);
    return this;
  }

  @override
  String toString() {
    final String colorStr = _buffer.toString();
    _buffer.clear();
    return colorStr;
  }

  @override
  String string() => _buffer.toString();
}

class ColorLogger {
  String tag = '';

  static final IColorBuilder builder = _ColorBuilder._();

  /// verbose
  void v(
    Object object, {
    String? tag,
    bool isDelegateZone = true,
  }) {
    final String data = '$_verboseSeq$object$_defaultColor';
    _printCall(data, tag ?? 'V', isDelegateZone);
  }

  void d(
    Object object, {
    String? tag,
    bool isDelegateZone = true,
  }) {
    final String data = '${_ansiCsi}1;34m$object\x1B[0m';
    _printCall(data, tag ?? 'D', isDelegateZone);
  }

  void i(
    Object object, {
    String? tag,
    bool isDelegateZone = true,
  }) {
    final String data = '${_ansiCsi}1;39m$object\x1B[0m';
    _printCall(data, tag ?? 'I', isDelegateZone);
  }

  void w(
    Object object, {
    String? tag,
    bool isDelegateZone = true,
  }) {
    final String data = '${_ansiCsi}1;33m$object\x1B[0m';
    _printCall(data, tag ?? 'W', isDelegateZone);
  }

  void e(
    Object object, {
    String? tag,
    bool isDelegate = true,
  }) {
    final String data = '${_ansiCsi}1;31m$object\x1B[0m';
    _printCall(data, tag ?? 'E', isDelegate);
  }

  void _printCall(String data, String tag, bool isDelegateZone) {
    final String msg = '$_verboseSeq[$tag] $data';
    if (isDelegateZone) {
      print(msg);
    } else {
      Zone.root.print(msg);
    }
  }

  void custom(
    Object object, {
    int? foreColor,
    int? backColor,
    String? tag,
    bool isDelegateZone = true,
  }) {
    String foreTag = '38';
    if (foreColor == null) {
      foreTag = '39';
    }

    final String backData =
        backColor == null ? '' : '${_ansiCsi}48;5;${backColor}m';

    _printCall(
      '$_ansiCsi$foreTag;5;${foreColor ?? '0'}m$backData$object$_defaultColor',
      tag ?? 'Custom',
      isDelegateZone,
    );
  }
}
