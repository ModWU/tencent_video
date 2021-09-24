import 'package:flutter/material.dart';

/// api地址的定义<中文注释特别拉胯，缩进格式有点问题>
///
/// api常量定义类，它有一个带参的构造函数，需要传递一个[path]字符串参数，[path]主要的组成形式为：
/// host + api。api中可以存在类似占位符的特殊标识：'{<标识名称>}'。当用户请求一个地址时，
/// 需要将带'{<标识名称>}'的占位符替换成标识名称对应的实际参数值。
///
/// '{<标识名称>}'占位符替换成实际参数值的方式有以下几种：
///  * 函数parameters(...)：最多支持四个参数。
///  * 函数parameterList(List<dynamic>)：支持参数列表，列表中的所有参数必须要和api中所有占
///    位符一一对应。
///  * 函数parameterMap(Map<String, dynamic>)：支持标识名称到参数值的映射关系，每一个含有
///    '{<标识名称>}'的api都必须添加标识名称的注释说明。
///
/// api地址[path]定义方式：
///  * [path] = host + api。
///  * [path] = host。
///  * [path] = api。
@immutable
class Api {
  const Api(String path)
      : assert(path != ''),
        _path = path;

  final String _path;

  static String? _globalHost;

  /// 获取全局host域名
  ///
  /// 获取的值为通过[setHost]函数设置的host值。
  static String? get globalHost => _globalHost;

  /// 设置全局host域名
  ///
  /// host设置规则：
  /// * 如果[path]中不存在host地址，实际上的host地址为通过[setHost]函数设置的host值。
  /// * 如果[path]中存在host地址，实际上的host地址优先选择[path]中的host地址，否则选取[setGlobalHost]
  ///   函数设置的host地址。
  static void setGlobalHost(String value) {
    if (_globalHost == value) return;
    _globalHost = value;
  }

  /// 替换'{<标识名称>}'占位符
  ///
  /// 参考:
  ///
  ///  * [parameters(dynamic first, ..., dynamic fourth)]
  Api call(dynamic first, [dynamic second, dynamic third, dynamic fourth]) =>
      _inject(first, second, third, fourth);

  /// 替换'{<标识名称>}'占位符
  ///
  /// 规则说明：
  ///  * 函数最多可传4个参数。
  ///  * 替换是按照传参顺序的，对应在[path]的替换顺序为从左到右。
  ///  * 所有替换的值必须要一一对应，且完全匹配。
  Api parameters(dynamic first,
          [dynamic second, dynamic third, dynamic fourth]) =>
      _inject(first, second, third, fourth);

  /// 替换'{<标识名称>}'占位符
  ///
  /// 规则说明：
  ///  * 函数参数需要传递一个List列表。
  ///  * 替换是按照传参顺序的，对应在[path]的替换顺序为从左到右。
  ///  * 所有替换的值必须要一一对应，且完全匹配。
  Api parameterList(List<dynamic> parameters) => _injectList(parameters);

  /// 替换'{<标识名称>}'占位符
  ///
  /// 规则说明：
  ///  * 函数参数需要传递一个Map映射表，表中的键对应'{<标识名称>}'占位符中的'标识名称'。
  ///  * 所有替换的值必须要一一对应，且完全匹配。
  Api parameterMap(Map<String, dynamic> parameters) => _injectMap(parameters);

  /// api中的真实[path]值
  ///
  /// [path]中host设置规则：
  /// * 如果[path]中不存在host地址，实际上的host地址为通过[setGlobalHost]函数设置的host值。
  /// * 如果[path]中存在host地址，实际上的host地址优先选择[path]中的host地址，否则选取[setGlobalHost]
  ///   函数设置的host地址。
  String get path {
    final List<String> paths = _parsePath();
    assert(paths.length == 2);
    final String host = paths[0];
    final String api = paths[1];

    final String realHost = host == '' ? (_globalHost ?? '') : host;

    return realHost + api;
  }

  /// api接口路径(不包括host域名)
  String get api {
    final List<String> paths = _parsePath();
    assert(paths.length == 2);
    final String api = paths[1];
    return api;
  }

  /// api中的真实host值
  ///
  /// host设置规则：
  /// * 如果[path]中不存在host地址，实际上的host地址为通过[setGlobalHost]函数设置的host值。
  /// * 如果[path]中存在host地址，实际上的host地址优先选择[path]中的host地址，否则选取[setGlobalHost]
  ///   函数设置的host地址。
  String get host {
    final List<String> paths = _parsePath();
    assert(paths.length == 2);
    final String host = paths[0];
    return host == '' ? (_globalHost ?? '') : '';
  }

  Api _injectList(List<dynamic> parameters) {
    assert(parameters.isNotEmpty == true);

    final List<String> paths = _parsePath();

    final String api = paths[1];
    assert(api != '');

    final List<String> parts = api.split('/');
    assert(parts.isNotEmpty == true);

    final List<dynamic> reversedParameters = parameters.reversed.toList();

    final List<String> newParts = parts.map<String>((String part) {
      return part.replaceAllMapped(RegExp(r'{(.+?)}'), (Match match) {
        final dynamic replacedValue =
            reversedParameters.isEmpty ? null : reversedParameters.removeLast();
        assert(replacedValue != null);
        return '$replacedValue';
      });
    }).toList();

    for (final dynamic remainParameter in reversedParameters) {
      assert(remainParameter == null);
    }

    return Api(paths[0] + newParts.join('/'));
  }

  List<String> _parsePath() {
    const String hostSep = '://';

    final List<String> hostApi = _path.split(hostSep);
    final int hostApiLength = hostApi.length;

    if (hostApiLength == 1) {
      return <String>['', hostApi[0]];
    }

    assert(hostApiLength == 2);

    final String secondPart = hostApi[1];

    String host = '';
    String api = '';

    final int firstSepIndex = secondPart.indexOf('/');
    assert(firstSepIndex != 0);
    if (firstSepIndex > 0) {
      host =
          '${hostApi[0]}$hostSep${secondPart.substring(0, firstSepIndex + 1)}';
      api = secondPart.substring(firstSepIndex + 1);
    } else {
      host = secondPart;
    }

    return <String>[host, api];
  }

  Api _inject(dynamic first, [dynamic second, dynamic third, dynamic fourth]) {
    assert(first != null);
    return _injectList(<dynamic>[first, second, third, fourth]);
  }

  Api _injectMap(Map<String, dynamic> parameters) {
    assert(parameters.isNotEmpty == true);

    final List<String> paths = _parsePath();

    final String api = paths[1];

    final List<String> parts = api.split('/');
    assert(parts.isNotEmpty == true);
    final List<String> newParts = parts.map<String>((String part) {
      return part.replaceAllMapped(RegExp(r'{(.+?)}'), (Match match) {
        assert(match.groupCount > 1);
        assert(match[1] != null);
        final String key = match[1]!.trim();
        assert(parameters.containsKey(key));
        return '${parameters.remove(key)}';
      });
    }).toList();

    assert(parameters.isEmpty);

    return Api(paths[0] + newParts.join('/'));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Api && other._path == _path;
  }

  @override
  int get hashCode => _path.hashCode;

  /// 返回api的path值
  @override
  String toString() => path;
}
