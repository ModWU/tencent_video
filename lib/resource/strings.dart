import 'dart:ui';

class LanguageCodes {
  const LanguageCodes._();

  static const String en = 'en';
  static const String zh = 'zh';

  static const String system = '';

  static const Locale defaultLocale = Locale.fromSubtags(languageCode: en);

  static Locale? getLocaleByLanguage(String language) =>
      language == system ? null : Locale.fromSubtags(languageCode: language);
}