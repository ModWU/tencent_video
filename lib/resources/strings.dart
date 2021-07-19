import 'dart:ui';

class LanguageCodes {
  const LanguageCodes._();

  static const String en = 'en';
  static const String zh = 'zh';

  static const Locale defaultLocale = Locale.fromSubtags(languageCode: en);

  static Locale? getLocaleByLanguage(String? language) {
    if (language == null) {
      return null;
    }
    return Locale.fromSubtags(languageCode: language);
  }
}
