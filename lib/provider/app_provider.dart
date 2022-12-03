import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  Locale? _locale;
  ThemeMode? _theme;

  ThemeMode? get theme => _theme;

  Locale? get locale => _locale;

  void setLocale(Locale? loc, [notify = true]) {
    _locale = loc;
    if (notify) {
      notifyListeners();
    }
  }

  void setTheme(ThemeMode? loc, [notify = true]) {
    _theme = loc;
    if (notify) {
      notifyListeners();
    }
  }
}
