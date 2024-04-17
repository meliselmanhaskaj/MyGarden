/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

mixin AppLocale {
  static const String app_title = 'app_title';

  static const Map<String, dynamic> EN = {app_title: 'Localization'};
  static const Map<String, dynamic> IT = {app_title: 'Localizzazione'};
}

class FlutterLocalization {
  static final FlutterLocalization instance = FlutterLocalization();

  late List<MapLocale> _mapLocales;
  late String _initLanguageCode;
  late Locale _currentLocale;
  late Function(Locale?) _onTranslatedLanguage;

  List<MapLocale> get mapLocales => _mapLocales;
  Locale get currentLocale => _currentLocale;
  List<Locale> get supportedLocales =>
      _mapLocales.map((e) => e.locale).toList();
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      GlobalMaterialLocalizations.delegates;

  String get fontFamily => '';

  void init({
    required List<MapLocale> mapLocales,
    required String initLanguageCode,
  }) {
    _mapLocales = mapLocales;
    _initLanguageCode = initLanguageCode;
    _currentLocale = Locale(_initLanguageCode);
  }

  void translate(String languageCode) {
    final locale = _mapLocales
        .firstWhere((element) => element.code == languageCode)
        .locale;
    _currentLocale = locale;
    _onTranslatedLanguage(locale);
  }

  void setTranslatedLanguageCallback(Function(Locale?) callback) {
    _onTranslatedLanguage = callback;
  }

  String getLanguageName(
      {required BuildContext context, String? languageCode}) {
    final appLocalizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations);

    if (appLocalizations == null) {
      return '';
    }

    if (languageCode != null) {
      return appLocalizations.translate('language_name_$languageCode');
    } else {
      return appLocalizations
          .translate('language_name_${_currentLocale.languageCode}');
    }
  }
}

class MapLocale {
  final String code;
  final Map<String, dynamic> data;
  late final Locale locale;

  MapLocale(this.code, this.data) {
    final languageCode = code.split('_')[0];
    final countryCode = code.split('_').length > 1 ? code.split('_')[1] : '';
    locale = Locale(languageCode, countryCode);
  }

  String getString(BuildContext context, String key) {
    return data[key] ?? key;
  }
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  late Map<String, dynamic> _localizedStrings;

  Future<bool> load() async {
    _localizedStrings = FlutterLocalization.instance.mapLocales
        .firstWhere((element) => element.locale == locale)
        .data;
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return FlutterLocalization.instance.supportedLocales.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.load();
    return appLocalizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
*/
