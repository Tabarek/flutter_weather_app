import 'package:flutter/material.dart';

class AppLanguage extends ChangeNotifier {
  Locale? _appLocale = Locale('en');

  Locale get appLocal => _appLocale!;
  fetchLocale() async {
    _appLocale = Locale('en');
  }

  void changeLanguage(Locale type) async {
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ar")) {
      _appLocale = Locale("ar");
    } else {
      _appLocale = Locale("en");
    }
    notifyListeners();
  }
}
