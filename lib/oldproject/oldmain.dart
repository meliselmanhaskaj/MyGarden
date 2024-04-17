/*
import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'services/localizationv0.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void setLocale(Locale locale) {
    setState(() {
      FlutterLocalization.instance.translate(locale.languageCode);
    });
  }

  @override
  void initState() {
    super.initState();
    FlutterLocalization.instance.init(
      mapLocales: [
        MapLocale('en', AppLocale.EN),
        MapLocale('it', AppLocale.IT),
      ],
      initLanguageCode: 'en',
    );
    FlutterLocalization.instance.setTranslatedLanguageCallback((locale) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Impostazioni Lingue',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      supportedLocales: FlutterLocalization.instance.supportedLocales,
      localizationsDelegates:
          FlutterLocalization.instance.localizationsDelegates,
    );
  }
}
*/
