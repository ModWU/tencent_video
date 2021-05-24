import 'package:flutter/material.dart';
import 'package:tencent_video/page/base/state.dart';
import 'package:tencent_video/page/state/attr.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 10, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    _tabController = null;
    super.dispose();
  }

  void _changeTabIndex(int index) {
    assert(index >= 0);
    assert(index < _tabController!.length);
    if (index == 3) {
      bootContext.changeNavigationBar(bootContext.bottomNavigationBar.value!
          .copyWith(
              backgroundColor: Colors.primaries[index % Colors.primaries.length]
                  .withOpacity(0.2)));
    } else {
      bootContext.changeNavigationBar(Attrs.defNavigationBarAttr);
    }
  }

  @override
  Widget build(BuildContext context) {
    //ColorTween
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          tabs: List.generate(10, (index) {
            return Tab(
              text: "video$index",
            );
          }).toList(),
          controller: _tabController,
          labelStyle: TextStyle(
            fontSize: 24,
            height: 1.5
          ),
          labelColor: Colors.redAccent,
          unselectedLabelColor: Colors.white,
          //labelPadding: EdgeInsets.only(top: 2),
          //duration: Duration(milliseconds: 30000),
          //indicatorPadding: EdgeInsets.only(top: 12),
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
            height: 1.0,
          ),
          onTap: _changeTabIndex,
          isScrollable: true,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(100),
        child: TweenAnimationBuilder<Color?>(
          duration: Duration(milliseconds: 5000),
          tween: ColorTween(
            begin: Color(0x00000000),
            end: Color(0xff000000),
          ),
          builder: (_, value, _$) {
            return Container(
              color: value,
            );
          },
        ),
      ),
    );
  }
}
