
/*

import 'package:flutter/material.dart';
import '../oldproject/localizationv0.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentLanguageCode = FlutterLocalization.instance.currentLocale.languageCode; // Imposta un valore di default se currentLocale o languageCode è null

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('app_title')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: currentLanguageCode,
              items: FlutterLocalization.instance.supportedLocales
                  // ignore: unnecessary_null_comparison
                  .where((locale) => locale != null) // Filtra eventuali valori null
                  .map<DropdownMenuItem<String>>(
                    (locale) => DropdownMenuItem(
                      value: locale.languageCode, // Sicuro di non essere null
                      child: Text(
                        FlutterLocalization.instance.getLanguageName(
                              context: context,
                              languageCode: locale.languageCode,
                            ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (newLanguageCode) {
                if (newLanguageCode != null) {
                  FlutterLocalization.instance.translate(newLanguageCode);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

*/

