import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterLocalizations {
  final Locale locale;
  Map<String, dynamic> _sentences;
  final bool isTest;

  FlutterLocalizations(this.locale, {this.isTest = false});

  static FlutterLocalizations of(BuildContext context) {
    return Localizations.of<FlutterLocalizations>(
        context, FlutterLocalizations);
  }

  Future<FlutterLocalizations> loadTest(Locale locale) async {
    return FlutterLocalizations(locale);
  }

  Future<FlutterLocalizations> load() async {
    String data = await rootBundle
        .loadString('lib/res/strings/${this.locale.languageCode}.json');
    this._sentences = json.decode(data);
    return FlutterLocalizations(locale);
  }

  String getString(String key) {
    if (isTest) {
      return key;
    }

    if (key == null || key.isEmpty) {
      return '...';
    }
    return this._sentences[key];
  }
}
