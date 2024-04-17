import 'package:flutter/material.dart';
import 'localization.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentLanguageCode = Localization.of(context)!.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context)!.trans('app_title')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: currentLanguageCode,
              items: Localization.supportedLocales()
                  .map<DropdownMenuItem<String>>(
                    (locale) => DropdownMenuItem(
                      value: locale.languageCode,
                      child: Text(locale.languageCode.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (newLanguageCode) {
                if (newLanguageCode != null) {
                  // Gestisci il cambiamento della lingua se necessario
                  Localization.of(context)!.changeLanguage(newLanguageCode);
                }
              },
            ),
            SizedBox(
                height: 20), // Aggiungi spazio tra il menu a discesa e la frase
            Text(
              Localization.of(context)!.trans('hello_message'),
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}


/*   

*/


/*

import 'package:address_24/src/lang/localization.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentLanguageCode = Localization.of(context)!.locale.languageCode;

     // Ottiene il codice lingua corrente

    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context)!.trans('app_title')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: currentLanguageCode,
              items: Localization.supportedLocales
                  .map<DropdownMenuItem<String>>(
                    (locale) => DropdownMenuItem(
                      value: locale.languageCode,
                      child: Text(
                        locale.languageCode.toUpperCase(), // Ad esempio, mostra il codice lingua in maiuscolo
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (newLanguageCode) {
                if (newLanguageCode != null) {
                  // Qui potresti gestire il cambiamento della lingua se necessario
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

