import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tencent_video/page/home/config.dart';
import 'package:tencent_video/resources/styles.dart';
import '../boot_manager.dart';
import '../base.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  ThemeStyle? themeStyle;

  int? _currentIndex;

  double? positionOffset;

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(initialIndex: _currentIndex = 1, length: 10, vsync: this);

    _tabController!.animation!.addListener(_changedTabPosition);
    themeStyle = ThemeStyle.normal;
  }

  @override
  void dispose() {
    _tabController!.animation!.removeListener(_changedTabPosition);
    _tabController!.dispose();

    _currentIndex = null;
    _tabController = null;
    super.dispose();
  }

  @override
  void changedThemeStyle() {
    if (isPage(PageCategory.home)) {
      themeStyle = bootContext.themeStyle.value;
    }
  }

  @override
  void changedPage() {
    if (isPage(PageCategory.home)) {
      bootContext.changeThemeStyle(themeStyle!);
      _tabController!.index = _currentIndex!;
    }
  }

  void _updateScrollPosition(ScrollMetrics scrollMetrics) {
    print("pixels: ${scrollMetrics.pixels}");
  }

  void _changedTabPosition() {
    final currentIndex = _tabController!.animation!.value.round();
    if (_tabController!.index != _currentIndex) {
      if (_tabController!.index == currentIndex) {
        _changedTabIndex(currentIndex);
      }
    } else if (currentIndex != _currentIndex) {
      _changedTabIndex(currentIndex);
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
    print("index: $index => ${_tabController!.offset}");
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData localTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Theme(
          data: localTheme.copyWith(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: NotificationListener(
            onNotification: (Notification notification) {
              if (notification is ScrollUpdateNotification) {
                final ScrollMetrics scrollMetrics = notification.metrics;
                if (scrollMetrics.axis == Axis.horizontal) {
                  _updateScrollPosition(scrollMetrics);
                }
              }
              return false;
            },
            child: TabBar(
              tabs: HomeConfigs.getTabs(context),
              controller: _tabController,
              physics: const BouncingScrollPhysics(),
              //overlayColor: MaterialStateProperty.all(Colors.transparent),
              labelPadding: EdgeInsets.symmetric(horizontal: 9.4),
              indicatorWeight: 0,
              indicator: const BoxDecoration(),
              //labelPadding: EdgeInsets.only(top: 2),
              isScrollable: true,
            ),
          ),
        ),
      ),
      body: DefaultTextStyle(
        style: bootContext.bodyText,
        child: TabBarView(
          controller: _tabController,
          physics: const BouncingScrollPhysics(),
          children: HomeConfigs.getViews(context),
        ),
      ),
    );
  }
}
