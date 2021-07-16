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

abstract class IAppState {}

class AppState<T> implements IAppState {
  AppState._(this.observer);

  final Observer<T> observer;

  static Map<IAppState, Listenable>? _allListenable;

  static Map<Object, Listenable>? _allBindListenable;

  static AppState<P> _from<P>(P p) {
    _allListenable ??= <IAppState, Listenable>{};

    final Observer<P> observer = p.ob;

    final AppState<P> state = AppState<P>._(observer);

    _allListenable![state] = observer;

    return state;
  }

  static Listenable bindListeners(Object key, List<IAppState> states) {
    assert(_allListenable?.isNotEmpty == true);
    assert(states.isNotEmpty);
    final List<Listenable> allListenable = states
        .where((IAppState state) => _allListenable!.containsKey(state))
        .map((IAppState state) => _allListenable![state]!)
        .toList();
    assert(allListenable.isNotEmpty);
    _allBindListenable ??= <Object, Listenable>{};
    return _allBindListenable![key] = Listenable.merge(allListenable);
  }

  static Listenable unbindListeners(Object key) {
    assert(_allBindListenable?.isNotEmpty == true);
    assert(_allListenable?.isNotEmpty == true);

    final Listenable? listenable = _allBindListenable!.remove(key);
    assert(listenable != null);

    if (_allBindListenable!.isEmpty) {
      _allBindListenable = null;
    }

    return listenable!;
  }

  static final AppState<PageCategory> page = AppState._from(PageCategory.home);

  static final AppState<ThemeStyle> theme = AppState._from(ThemeStyle.normal);

  static final AppState<Locale> language =
      AppState._from(AppUtils.getLocalByCode(LanguageCodes.en));
}

@optionalTypeArgs
mixin BootMiXin<T extends StatefulWidget> on State<T> {
  BootContext get bootContext => BootContext.get();

  @protected
  void changedPage() {}

  @protected
  void changedThemeStyle() {}

  bool isPageAt(PageCategory page) {
    return bootContext.isPageAt(page);
  }

  @override
  void initState() {
    super.initState();
    bootContext.page.addListener(changedPage);
    bootContext.themeStyle.addListener(changedThemeStyle);
  }

  @override
  void dispose() {
    bootContext.page.removeListener(changedPage);
    bootContext.themeStyle.removeListener(changedThemeStyle);
    super.dispose();
  }
}
