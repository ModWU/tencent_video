//display mode: 0(default) 1(highlight) 22(not bold) 4(underline) 24(not underline) 5(flicker) 25(not flicker) 7(reverse show) 27(not reverse show)
//foreground: 30(black) 31(red) 32(green) 33(yellow) 34(blue) 35(carmine) 36(cyan) 37(white)
//background: 40(black) 41(red) 42(green) 43(yellow) 44(blue) 45(carmine) 46(cyan) 47(white)

import 'dart:async';

String _ansiCsi = '\x1b[';
String _defaultColor = '${_ansiCsi}0m';
String _verboseSeq = '${_ansiCsi}38;5;244m';

class ColorLogger {
  final StringBuffer _buffer = StringBuffer();

  StringBuffer get buffer => _buffer;

  String tag = '';

  String setColor(
    Object object, {
    int? foreColor,
    int? backColor,
    bool isDelegateZone = true,
  }) {
    String foreTag = '38';
    if (foreColor == null) {
      foreTag = '39';
    }

    final String backData =
        backColor == null ? '' : '${_ansiCsi}48;5;${backColor}m';

    return '$_ansiCsi$foreTag;5;${foreColor ?? '0'}m$backData$object$_defaultColor';
  }

  /// verbose
  void v(
    Object object, {
    String? tag,
    bool isDelegateZone = true,
  }) {
    final String data = '$_verboseSeq$object$_defaultColor';
    String suffix = '';
    if (!object.toString().endsWith('\n')) {
      suffix += '\n';
    }
    _buffer.write(data + suffix);
    _printCall(data, tag ?? 'V', isDelegateZone);
  }

  void d(
    Object object, {
    String? tag,
    bool isDelegateZone = true,
  }) {
    final String data = '${_ansiCsi}1;34m$object\x1B[0m';
    String suffix = '';
    if (!object.toString().endsWith('\n')) {
      suffix += '\n';
    }
    _buffer.write(data + suffix);
    _printCall(data, tag ?? 'D', isDelegateZone);
  }

  void i(
    Object object, {
    String? tag,
    bool isDelegateZone = true,
  }) {
    final String data = '${_ansiCsi}1;39m$object\x1B[0m';
    String suffix = '';
    if (!object.toString().endsWith('\n')) {
      suffix += '\n';
    }
    _buffer.write(data + suffix);
    _printCall(data, tag ?? 'I', isDelegateZone);
  }

  void w(
    Object object, {
    String? tag,
    bool isDelegateZone = true,
  }) {
    final String data = '${_ansiCsi}1;33m$object\x1B[0m';
    String suffix = '';
    if (!object.toString().endsWith('\n')) {
      suffix += '\n';
    }
    _buffer.write(data + suffix);
    _printCall(data, tag ?? 'W', isDelegateZone);
  }

  void e(
    Object object, {
    String? tag,
    bool isDelegate = true,
  }) {
    final String data = '${_ansiCsi}1;31m$object\x1B[0m';
    String suffix = '';
    if (!object.toString().endsWith('\n')) {
      suffix += '\n';
    }
    _buffer.write(data + suffix);
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
