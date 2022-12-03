import 'dart:ui';

enum Language {
  kk,
  ru,
  en;

  String localedName() {
    switch (this) {
      case Language.kk:
        return "Қазақ тілі";
      case Language.ru:
        return "Русский";
      case Language.en:
        return "English";
    }
  }

  static String languageName(String language) {
    switch (language) {
      case "KK":
        return "Қазақ тілі";
      case "RU":
        return "Русский";
      default:
        return "English";
    }
  }

  Locale get locale => Locale(name);
}
