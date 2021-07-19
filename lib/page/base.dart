import 'package:flutter/material.dart';
import 'package:tencent_video/common/listener/ob.dart';
import 'package:tencent_video/common/utils/app_utils.dart';
import 'package:tencent_video/resources/strings.dart';
import 'package:tencent_video/resources/styles.dart';
import 'boot_manager.dart';

enum PageCategory {
  home,
  doki,
  vip,
  message,
  person,
}

class AppState<T> extends Observer<T> {
  AppState._(T value) : super(value);

  static List<Listenable>? _allListeners;

  static Map<Object, Listenable>? _allBindListeners;

  static AppState<T> _from<T>(T value) {
    _allListeners ??= <Listenable>[];

    final AppState<T> state = AppState<T>._(value);

    _allListeners!.add(state);

    return state;
  }

  static Listenable bindListeners(Object key, List<Listenable> listeners) {
    assert(_allListeners!.isNotEmpty);
    assert(listeners.isNotEmpty);
    assert(_allBindListeners == null || !_allBindListeners!.containsKey(key));
    for (final Listenable listener in listeners)
      assert(_allListeners!.contains(listener));

    _allBindListeners ??= <Object, Listenable>{};
    return _allBindListeners![key] = Listenable.merge(listeners);
  }

  static Listenable unbindListeners(Object key) {
    assert(_allListeners!.isNotEmpty);
    assert(_allBindListeners?.isNotEmpty == true);

    final Listenable? listenable = _allBindListeners!.remove(key);
    assert(listenable != null);

    if (_allBindListeners!.isEmpty) {
      _allBindListeners = null;
    }

    return listenable!;
  }

  static final AppState<PageCategory> page = AppState._from(PageCategory.home);

  static final AppState<ThemeStyle> theme = AppState._from(ThemeStyle.normal);

  static final AppState<String> language = AppState._from(LanguageCodes.en);
}

@optionalTypeArgs
mixin BootMiXin<T extends StatefulWidget> on State<T> {
  BootContext get bootContext => BootContext.get();

  @protected
  void pageChanged() {}

  @protected
  void themeChanged() {}

  bool isPageAt(PageCategory page) {
    return bootContext.isPageAt(page);
  }

  @override
  void initState() {
    super.initState();
    bootContext.page.addListener(pageChanged);
    bootContext.theme.addListener(themeChanged);
  }

  @override
  void dispose() {
    bootContext.page.removeListener(pageChanged);
    bootContext.theme.removeListener(themeChanged);
    super.dispose();
  }
}
