import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Localization {
  Localization(this.locale);
  final Locale locale;

  static Localization? of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  late Map<String, String> _sentences = {};

  Future<bool> load() async {
    String data = await rootBundle
        .loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);
    _sentences = Map<String, String>.from(_result);
    return true;
  }

  String trans(String key) {
    return _sentences[key] ?? key;
  }

  static List<Locale> supportedLocales() {
    return [
      const Locale('en', 'US'),
      const Locale('it', 'IT'),
    ];
  }

  void changeLanguage(String newLanguageCode) async {
    // Ricarica le traduzioni per la nuova lingua
    Locale newLocale = Locale(newLanguageCode);
    Localization newLocalization = Localization(newLocale);
    await newLocalization.load();
    _sentences = newLocalization._sentences;
  }
}


/*
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Localization {
  Localization(this.locale) : _sentences = {}; // Inizializzazione diretta del campo _sentences
  final Locale locale;
  
  late Map<String, String> _sentences; // Segnalazione come late

  Future<bool> load() async {
    String data = await rootBundle.loadString('assets/lang/${this.locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);
    this._sentences = {}; // Inizializzazione diretta del campo _sentences
    
    _result.forEach((String key, dynamic value) {
      this._sentences[key] = value.toString();
    });
    
    return true;
  }
  
  String trans(String key) {
    return this._sentences[key] ?? ''; // Gestione del valore potenzialmente nullo
  }
  
    static List<Locale> supportedLocales() {
    return [
      const Locale('en', 'US'),
      const Locale('it', 'IT'),
      // Aggiungi qui altre lingue supportate, se necessario
    ];
  }


  static Localization? of(BuildContext context) { // Restituzione di un tipo non nullabile
    return Localizations.of<Localization>(context, Localization);
  }
}


  

*/