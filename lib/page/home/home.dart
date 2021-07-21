import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tencent_video/common/logs/app_log.dart';
import 'package:tencent_video/page/home/config.dart';
import 'package:tencent_video/resources/styles.dart';
import '../app_state.dart';
import '../base.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with BootMiXin, TickerProviderStateMixin {
  TabController? _tabController;

  TabController? _tabViewController;

  ThemeStyle? themeStyle;

  int? _currentIndex;

  final GlobalKey _tabBarKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: _currentIndex = 1,
        length: HomeConfigs.length,
        vsync: this);

    _tabViewController = TabController(
        initialIndex: _currentIndex!, length: HomeConfigs.length, vsync: this);

    _tabController!.animation!.addListener(_changedTabPosition);
    _tabViewController!.animation!.addListener(_changeTabViewPosition);

    themeStyle = bootContext.theme.value;
  }

  @override
  void dispose() {
    _tabController!.animation!.removeListener(_changedTabPosition);
    _tabViewController!.animation!.removeListener(_changeTabViewPosition);
    _tabController!.dispose();
    _tabViewController!.dispose();

    _currentIndex = null;
    _tabController = null;
    super.dispose();
  }

  @override
  void themeChanged() {
    if (isPageAt(PageCategory.home)) {
      themeStyle = bootContext.theme.value;
    }
  }

  @override
  void pageChanged() {
    if (isPageAt(PageCategory.home)) {
      bootContext.changeThemeStyle(themeStyle!);
     /* final StatefulElement? element =
          _tabBarKey.currentContext as StatefulElement?;
      final TabBarState? tabBarState = element?.state as TabBarState?;
      if (tabBarState != null) {
        tabBarState.scrollToCurrentIndex();
      }*/
    }
  }

  void _changeTabViewPosition() {
    final int tabViewIndex = _tabViewController!.animation!.value.round();

    Logger.log('tabViewIndex: $tabViewIndex, _currentIndex: $_currentIndex');

    if (tabViewIndex != _currentIndex) {
      _changedTabIndex(tabViewIndex);
      _waitingTabAnimationState();
      _tabController!.animateTo(_currentIndex!);
    }
  }

  void _waitingTabAnimationState() {
    void animationStatusListener(AnimationStatus status) {
      switch (status) {
        case AnimationStatus.forward:
          _tabController!.animation!.removeListener(_changedTabPosition);
          break;

        case AnimationStatus.completed:
          _tabController!.animation!.removeListener(_changedTabPosition);
          _tabController!.animation!.addListener(_changedTabPosition);
          _tabController!.animation!
              .removeStatusListener(animationStatusListener);
          break;
      }
    }

    _tabController!.animation!.removeStatusListener(animationStatusListener);
    _tabController!.animation!.addStatusListener(animationStatusListener);
  }

  void _changedTabPosition() {
    Logger.log('_changedTabPosition');
    final int currentIndex = _tabController!.animation!.value.round();
    if (_tabController!.index != _currentIndex) {
      if (_tabController!.index == currentIndex) {
        _changedTabIndex(currentIndex);
        //tabView没有任何动画，所以不需要移除动画监听
        _tabViewController!.index = _currentIndex!;
        //_tabViewController!.animateTo(_currentIndex!, duration: Duration(milliseconds: 5000), curve: Curves.ease);
      }
    } else if (currentIndex != _currentIndex) {
      _changedTabIndex(currentIndex);
      _tabViewController!.index = _currentIndex!;
      //_tabViewController!.animateTo(_currentIndex!, duration: Duration(milliseconds: 5000), curve: Curves.ease);
    }
  }

  void _changedTabIndex(int index) {
    assert(index >= 0);
    assert(index < _tabController!.length);
    _currentIndex = index;
    if (index == 2) {
      bootContext.changeThemeStyle(ThemeStyle.dark);
    } else {
      bootContext.changeThemeStyle(ThemeStyle.light);
    }
    Logger.log('index: $index => ${_tabController!.offset}');
  }

  @override
  Widget build(BuildContext context) {
    Logger.log("home build");
    final ThemeData localTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Theme(
          data: localTheme.copyWith(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: TabBar(
            key: _tabBarKey,
            tabs: HomeConfigs.getTabs(context),
            controller: _tabController,
            physics: const BouncingScrollPhysics(),
            indicatorWeight: 0,
            indicator: const BoxDecoration(),
            isScrollable: true,
          ),
        ),
      ),
      body: DefaultTextStyle(
        style: bootContext.bodyText,
        child: TabBarView(
          controller: _tabViewController,
          physics: const BouncingScrollPhysics(),
          children: HomeConfigs.getViews(context),
        ),
      ),
    );
  }
}
