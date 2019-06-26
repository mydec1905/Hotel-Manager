import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_manager/localization/flutter_localizations.dart';


class FlutterLocalizationsDelegate
    extends LocalizationsDelegate<FlutterLocalizations> {
  static List<Locale> get supportedLocales =>
      [const Locale('en', 'US'), const Locale('vi', 'VN')];

  final bool isTest;

  const FlutterLocalizationsDelegate({
    this.isTest = false,
  });

  @override
  bool isSupported(Locale locale) {
    if (supportedLocales.any((l) => l.languageCode == locale.languageCode)) {
      return true;
    }
    print(
        "Missing support for requested locale '${locale.countryCode}|${locale.languageCode}'.");
    return false;
  }

  @override
  Future<FlutterLocalizations> load(Locale locale) async {
    FlutterLocalizations localizations =
        new FlutterLocalizations(locale, isTest: this.isTest);

    if (this.isTest) {
      await localizations.loadTest(locale);
    } else {
      await localizations.load();
    }

    print("Load ${locale.languageCode}");

    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<FlutterLocalizations> old) {
    return false;
  }
}
