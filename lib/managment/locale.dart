import 'package:flutter/material.dart';

class LocaleManagment extends ChangeNotifier {
  Locale locale;

  void setLocale({Locale locale}) {
    this.locale = locale;
    notifyListeners();
  }
}
