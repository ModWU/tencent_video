import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tencent_video/common/listener/tap_notify.dart';
import 'package:tencent_video/generated/l10n.dart';
import 'package:tencent_video/page/manager/boot_manager.dart';
import 'package:tencent_video/page/person.dart';
import 'package:tencent_video/page/vip.dart';
import 'package:tencent_video/ui/state/rive_state.dart';
import 'base/state.dart';
import 'doki.dart';
import 'home.dart';
import 'message.dart';

class Boot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BootState();
}

class _BootState extends State<Boot> with BootManager {
  ThemeData get _themeData {
    switch (page.value!) {
      case PageCategory.home:
        return Theme.of(context).copyWith(primaryColor: Colors.grey);

      case PageCategory.doki:
        return Theme.of(context).copyWith(primaryColor: Colors.white);

      case PageCategory.vip:
        return Theme.of(context).copyWith(primaryColor: Colors.black);

      case PageCategory.message:
        return Theme.of(context).copyWith(primaryColor: Colors.white);

      case PageCategory.person:
        return Theme.of(context).copyWith(primaryColor: Colors.white);
    }
  }

  Widget get _body {
    return IndexedStack(
      index: page.value!.index,
      children: [
        HomePage(),
        DokiPage(),
        VipPage(),
        MessagePage(),
        PersonPage(),
      ],
    );
  }

  Widget get _bottomNavigationBar => _BottomNavigationBarWidget();

  @override
  void initState() {
    super.initState();
    page.addListener(_pageChanger);
  }

  @override
  void dispose() {
    page.removeListener(_pageChanger);
    super.dispose();
  }

  void _pageChanger() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return startBoot(
      child: Theme(
        data: _themeData,
        child: Scaffold(
          bottomNavigationBar: _bottomNavigationBar,
          body: _body,
        ),
      ),
    );
  }
}

class _BottomNavigationBarWidget extends StatefulWidget {

  const _BottomNavigationBarWidget();

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState
    extends BaseState<_BottomNavigationBarWidget> {

  TapListener? _pageTapListener;

  @override
  void updateBootContext(BootContext? oldBootContext) {
    _pageTapListener = new TapListener(bootContext.page.value!);
    _updateListener(oldBootContext);
  }

  void _updateListener(BootContext? oldBootContext) {
    oldBootContext?.page.removeListener(_pageListener);
    oldBootContext?.bottomNavigationBar.removeListener(_bottomNavigationBarListener);
    bootContext.page.addListener(_pageListener);
    bootContext.bottomNavigationBar.addListener(_bottomNavigationBarListener);
  }

  void _disposeListener() {
    bootContext.page.removeListener(_pageListener);
    bootContext.bottomNavigationBar.removeListener(_bottomNavigationBarListener);
  }

  void _pageListener() {
    _pageTapListener!.onTap(bootContext.page.value!);
  }

  void _bottomNavigationBarListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _disposeListener();
    _pageTapListener = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: _getRiveIcon(PageCategory.home, 20),
            label: S.of(context).home_tle),
        BottomNavigationBarItem(
            icon: _getRiveIcon(PageCategory.doki, 20),
            label: S.of(context).doki_tle),
        BottomNavigationBarItem(
            icon: _getRiveIcon(PageCategory.vip, 20),
            label: S.of(context).vip_tle),
        BottomNavigationBarItem(
            icon: _getRiveIcon(PageCategory.message, 20),
            label: S.of(context).message_tle),
        BottomNavigationBarItem(
            icon: _getRiveIcon(PageCategory.person, 20),
            label: S.of(context).person_tle),
      ],
      currentIndex: bootContext.page.value!.index,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.red,
      backgroundColor: bootContext.bottomNavigationBar.value!.backgroundColor,
      unselectedFontSize: 12,
      selectedFontSize: 12,
      iconSize: 20,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 4,
      onTap: (int index) {
        bootContext.page.value = PageCategory.values[index];
      },
    );
  }

  Widget _getRiveIcon(PageCategory page, double size) {
    switch (page) {
      case PageCategory.home:
        return RiveSimpleStateMachineWidget(
            uri: "assets/mr-help.riv",
            stateMachineName: "State Machine 1",
            input: "Wrong",
            size: size,
            tapListener: _pageTapListener!,
            value: PageCategory.home);
      case PageCategory.doki:
        return RiveSimpleWidget(
            uri: "assets/landing-animation.riv",
            animationName: "Landing",
            size: size,
            useArtboardSize: true,
            tapListener: _pageTapListener!,
            value: PageCategory.doki);
      case PageCategory.vip:
        return RiveSimpleStateMachineWidget(
            uri: "assets/mr-help.riv",
            stateMachineName: "State Machine 1",
            input: "Speak",
            size: size,
            tapListener: _pageTapListener!,
            value: PageCategory.vip);
      case PageCategory.message:
        return RiveSimpleStateMachineWidget(
            uri: "assets/mr-help.riv",
            stateMachineName: "State Machine 1",
            input: "Speak",
            size: size,
            tapListener: _pageTapListener!,
            value: PageCategory.message);
      case PageCategory.person:
        return RiveSimpleStateMachineWidget(
            uri: "assets/mr-help.riv",
            stateMachineName: "State Machine 1",
            input: "Happy",
            size: size,
            tapListener: _pageTapListener!,
            value: PageCategory.person);
    }
  }
}
