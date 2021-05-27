// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
 
      return instance;
    });
  } 

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null, 'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `tencent video`
  String get title {
    return Intl.message(
      'tencent video',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get home_tle {
    return Intl.message(
      'home',
      name: 'home_tle',
      desc: '',
      args: [],
    );
  }

  /// `doki`
  String get doki_tle {
    return Intl.message(
      'doki',
      name: 'doki_tle',
      desc: '',
      args: [],
    );
  }

  /// `VIP`
  String get vip_tle {
    return Intl.message(
      'VIP',
      name: 'vip_tle',
      desc: '',
      args: [],
    );
  }

  /// `message`
  String get message_tle {
    return Intl.message(
      'message',
      name: 'message_tle',
      desc: '',
      args: [],
    );
  }

  /// `person`
  String get person_tle {
    return Intl.message(
      'person',
      name: 'person_tle',
      desc: '',
      args: [],
    );
  }

  /// `subscribe`
  String get sub_txt {
    return Intl.message(
      'subscribe',
      name: 'sub_txt',
      desc: '',
      args: [],
    );
  }

  /// `choiceness`
  String get cho_txt {
    return Intl.message(
      'choiceness',
      name: 'cho_txt',
      desc: '',
      args: [],
    );
  }

  /// `discover`
  String get dis_txt {
    return Intl.message(
      'discover',
      name: 'dis_txt',
      desc: '',
      args: [],
    );
  }

  /// `NBA`
  String get nba_txt {
    return Intl.message(
      'NBA',
      name: 'nba_txt',
      desc: '',
      args: [],
    );
  }

  /// `teleplay`
  String get tel_txt {
    return Intl.message(
      'teleplay',
      name: 'tel_txt',
      desc: '',
      args: [],
    );
  }

  /// `movie`
  String get mov_txt {
    return Intl.message(
      'movie',
      name: 'mov_txt',
      desc: '',
      args: [],
    );
  }

  /// `variety`
  String get var_txt {
    return Intl.message(
      'variety',
      name: 'var_txt',
      desc: '',
      args: [],
    );
  }

  /// `children`
  String get chi_txt {
    return Intl.message(
      'children',
      name: 'chi_txt',
      desc: '',
      args: [],
    );
  }

  /// `cartoon`
  String get car_txt {
    return Intl.message(
      'cartoon',
      name: 'car_txt',
      desc: '',
      args: [],
    );
  }

  /// `documentary`
  String get doc_txt {
    return Intl.message(
      'documentary',
      name: 'doc_txt',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}