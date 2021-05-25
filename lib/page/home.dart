import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tencent_video/common/listener/ob.dart';
import 'package:tencent_video/page/attr/static_attr.dart';
import 'package:tencent_video/page/base/state.dart';
import 'package:tencent_video/page/manager/boot_manager.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  ThemeStyle? themeStyle;

  Ob<ThemeData>? themeData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 10, vsync: this);
    themeStyle = ThemeStyle.normal;
    themeData = ThemeAttrs.get(ThemeStyle.normal).ob;
  }

  @override
  void dispose() {
    _tabController!.dispose();
    _tabController = null;
    themeData = null;
    super.dispose();
  }

  @override
  void changedThemeStyle() {
    if (isPage(PageCategory.home)) {
      themeStyle = bootContext.themeStyle.value;
      themeData!.value = bootContext.themeData;
    }
  }

  @override
  void changedPage() {
    if (isPage(PageCategory.home)) {
      bootContext.changeThemeStyle(themeStyle!);
    }
  }

  void _changeTabIndex(int index) {
    assert(index >= 0);
    assert(index < _tabController!.length);
    if (index == 3) {
      bootContext.changeThemeStyle(ThemeStyle.dark);
      //_changeStatusBar(WidgetAttrs.darkStatusBarAttr);
    } else {
      bootContext.changeThemeStyle(ThemeStyle.light);
      //_changeStatusBar(WidgetAttrs.lightStatusBarAttr);
    }
  }

  @override
  Widget build(BuildContext context) {
    //ColorTween
    final ThemeData localTheme = Theme.of(context);
    return TweenAnimationBuilder<ThemeData?>(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOut,
      tween: ThemeDataTween(
        end: localTheme,
      ),
      builder: (context, ThemeData? value, _) {
        return Scaffold(
          appBar: AppBar(
            title: Theme(
              data: localTheme.copyWith(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              child: TabBar(
                tabs: List.generate(10, (index) {
                  return Tab(
                    text: "video$index",
                  );
                }).toList(),
                controller: _tabController,
                labelStyle: TextStyle(fontSize: 24, height: 1.8),
                labelColor: Colors.redAccent,
                unselectedLabelColor: Colors.grey,
                physics: const BouncingScrollPhysics(),
                //overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicatorWeight: 0,
                indicator: const BoxDecoration(),
                //labelPadding: EdgeInsets.only(top: 2),
                unselectedLabelStyle: TextStyle(fontSize: 14, height: 1.0),
                onTap: _changeTabIndex,
                isScrollable: true,
              ),
            ),
            backgroundColor: value!.appBarTheme.backgroundColor,
          ),
          body: DefaultTextStyle(
            style: bootContext.bodyText,
            child: Padding(
              padding: EdgeInsets.all(100),
              child: TweenAnimationBuilder<Color?>(
                duration: Duration(milliseconds: 5000),
                tween: ColorTween(
                  begin: Color(0x00000000),
                  end: Color(0xff000000),
                ),
                builder: (_, value, _$) {
                  return Text(
                    "click",
                    style: TextStyle(
                      fontSize: 36,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}


/*typedef PreferredSizeWidgetBuilder<T> = PreferredSizeWidget Function(BuildContext context, T value, Widget? child);

class ThemeTween extends StatelessWidget implements PreferredSizeWidget {

  final PreferredSizeWidgetBuilder<ThemeData> builder;

  const ThemeTween({required this.builder}) : preferredSize = Size.fromHeight(toolbarHeight ?? kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    print("build theme ...");
    return TweenAnimationBuilder<ThemeData?>(
      duration: Duration(milliseconds: 5000),
      tween: ThemeDataTween(
        end: Theme.of(context),
      ),
      builder: builder,
    );
  }



}*/
