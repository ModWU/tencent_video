import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tencent_video/common/listener/tap.dart';
import 'package:tencent_video/generated/l10n.dart';
import 'package:tencent_video/page/person/person.dart';
import 'package:tencent_video/page/vip/vip.dart';
import 'package:tencent_video/resources/strings.dart';
import 'package:tencent_video/resources/styles.dart';
import 'package:tencent_video/ui/state/rive_state.dart';
import 'base.dart';
import 'boot_manager.dart';
import 'doki/doki.dart';
import 'home/home.dart';
import 'message/message.dart';

class Boot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BootState();
}

class _BootState extends State<Boot> with BootManager {
  ThemeData? _themeData;

  @override
  void initState() {
    super.initState();
    _themeData = ThemeAttrs.get(themeStyle.value!);
    page.addListener(_rebuild);
    locale.addListener(_rebuild);
    themeStyle.addListener(_changedThemeStyle);
  }

  @override
  void dispose() {
    page.removeListener(_rebuild);
    locale.removeListener(_rebuild);
    themeStyle.removeListener(_changedThemeStyle);
    _themeData = null;
    super.dispose();
  }

  void _rebuild() {
    setState(() {});
  }

  void _changedThemeStyle() {
    setState(() {
      _themeData = ThemeAttrs.get(themeStyle.value!);
    });
  }

  Locale? _handleLocales(
      List<Locale>? locales, Iterable<Locale> supportedLocales) {
    List<Locale>? currentLocales;
    if (locales?.isNotEmpty == true) {
      for (final Locale locale in locales!) {
        if (S.delegate.isSupported(locale)) {
          currentLocales ??= <Locale>[];
          currentLocales.add(locale);
        }
      }
    }
    return currentLocales?.isNotEmpty == true
        ? currentLocales!.first
        : const Locale.fromSubtags(languageCode: LanguageCodes.en);
  }

  @override
  Widget build(BuildContext context) {
    return RootRestorationScope(
      restorationId: 'root',
      child: MaterialApp(
        localizationsDelegates: _delegates,
        supportedLocales: S.delegate.supportedLocales,
        locale: locale.value,
        localeListResolutionCallback: _handleLocales,
        theme: themeData,
        home: Scaffold(
          bottomNavigationBar: const _BottomNavigationBarWidget(),
          body: IndexedStack(
            index: page.value!.index,
            children: <Widget>[
              HomePage(),
              DokiPage(),
              VipPage(),
              MessagePage(),
              PersonPage(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  TextStyle get bodyText => _themeData!.textTheme.bodyText1!;

  @override
  ThemeData get themeData => _themeData!;
}

class _BottomNavigationBarWidget extends StatefulWidget {
  const _BottomNavigationBarWidget();

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<_BottomNavigationBarWidget>
    with BootMiXin {
  TapListener? _pageTapListener;

  @override
  void initState() {
    super.initState();
    _pageTapListener = TapListener(bootContext.page.value!);
  }

  @override
  void changedPage() {
    _pageTapListener!.onTap(bootContext.page.value!);
  }

  @override
  void dispose() {
    _pageTapListener = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData localTheme = Theme.of(context);
    return Theme(
      data: localTheme.copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: _getRiveIcon(PageCategory.home, 20),
              tooltip: '',
              label: S.of(context).home_tle),
          BottomNavigationBarItem(
              icon: _getRiveIcon(PageCategory.doki, 20),
              tooltip: '',
              label: S.of(context).doki_tle),
          BottomNavigationBarItem(
              icon: _getRiveIcon(PageCategory.vip, 20),
              tooltip: '',
              label: S.of(context).vip_tle),
          BottomNavigationBarItem(
              icon: _getRiveIcon(PageCategory.message, 20),
              tooltip: '',
              label: S.of(context).message_tle),
          BottomNavigationBarItem(
              icon: _getRiveIcon(PageCategory.person, 20),
              tooltip: '',
              label: S.of(context).person_tle),
        ],
        currentIndex: bootContext.page.value!.index,
        iconSize: 20,
        onTap: (int index) {
          bootContext.page.value = PageCategory.values[index];
        },
      ),
    );
  }

  Widget _getRiveIcon(PageCategory page, double size) {
    switch (page) {
      case PageCategory.home:
        return RiveSimpleStateMachineWidget(
            uri: 'assets/mr-help.riv',
            stateMachineName: 'State Machine 1',
            input: 'Wrong',
            size: size,
            tapListener: _pageTapListener!,
            value: PageCategory.home);
      case PageCategory.doki:
        return RiveSimpleWidget(
            uri: 'assets/landing-animation.riv',
            animationName: 'Landing',
            size: size,
            useArtboardSize: true,
            tapListener: _pageTapListener!,
            value: PageCategory.doki);
      case PageCategory.vip:
        return RiveSimpleStateMachineWidget(
            uri: 'assets/mr-help.riv',
            stateMachineName: 'State Machine 1',
            input: 'Speak',
            size: size,
            tapListener: _pageTapListener!,
            value: PageCategory.vip);
      case PageCategory.message:
        return RiveSimpleStateMachineWidget(
            uri: 'assets/mr-help.riv',
            stateMachineName: 'State Machine 1',
            input: 'Speak',
            size: size,
            tapListener: _pageTapListener!,
            value: PageCategory.message);
      case PageCategory.person:
        return RiveSimpleStateMachineWidget(
            uri: 'assets/mr-help.riv',
            stateMachineName: 'State Machine 1',
            input: 'Happy',
            size: size,
            tapListener: _pageTapListener!,
            value: PageCategory.person);
    }
  }
}

const List<LocalizationsDelegate<dynamic>> _delegates =
    <LocalizationsDelegate<dynamic>>[
  /*GlobalCupertinoLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,*/
  ...GlobalMaterialLocalizations.delegates,
  S.delegate,
];
