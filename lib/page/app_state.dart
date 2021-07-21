import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tencent_video/common/listener/ob.dart';
import 'package:tencent_video/common/utils/app_utils.dart';
import 'package:tencent_video/resources/strings.dart';
import 'package:tencent_video/resources/styles.dart';

enum PageCategory {
  home,
  doki,
  vip,
  message,
  person,
}

class AppState<T> extends Observer<T> {
  AppState._(T value) : super(value);

  @override
  T get value => super.value!;

  static List<Listenable>? _allListeners;

  static Map<Object, Listenable>? _allBindListeners;

  static bool? _initialized;

  static Zone? _appZone;

  static bool get initialized => _initialized == true;

  static Zone get appZone => _appZone!;

  static AppState<T> _from<T>(T value) {
    _allListeners ??= <Listenable>[];

    final AppState<T> state = AppState<T>._(value);

    _allListeners!.add(state);

    return state;
  }

  static Listenable bindListeners(Object key, List<Listenable> listeners) {
    assert(initialized);
    assert(_allListeners!.isNotEmpty);
    assert(listeners.isNotEmpty);
    assert(_allBindListeners == null || !_allBindListeners!.containsKey(key));
    for (final Listenable listener in listeners)
      assert(_allListeners!.contains(listener));

    _allBindListeners ??= <Object, Listenable>{};
    return _allBindListeners![key] = Listenable.merge(listeners);
  }

  static Listenable unbindListeners(Object key) {
    assert(initialized);
    assert(_allListeners!.isNotEmpty);
    assert(_allBindListeners?.isNotEmpty == true);

    final Listenable? listenable = _allBindListeners!.remove(key);
    assert(listenable != null);

    if (_allBindListeners!.isEmpty) {
      _allBindListeners = null;
    }

    return listenable!;
  }

  static Future<void> initialize() async {
    assert(!initialized);
    _initialized = true;
    _appZone = Zone.current;
    AppUtils.setAppSystemUIOverlayStyle();
    print('模拟十秒初始化');
    await Future<void>.delayed(const Duration(milliseconds: 10000));
    page.value = PageCategory.doki;
    language.value = LanguageCodes.system;
    print(
        '模拟十秒初始化 root: ${Zone.root.hashCode} current: ${Zone.current.hashCode} zone.name: ${Zone.current['name']}');
  }

  static void doDispose() {
    assert(initialized);
    _initialized = null;
    _appZone = null;
    _allListeners = null;
    _allBindListeners = null;
  }

  static final AppState<PageCategory> page = AppState._from(PageCategory.home);

  static final AppState<ThemeStyle> theme = AppState._from(ThemeStyle.normal);

  static final AppState<String> language = AppState._from(LanguageCodes.en);
}
