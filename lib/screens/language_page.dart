import 'package:flutter/material.dart';
import 'file:C:/Users/marco/Downloads/MyGarden-marco/MyGarden-main/lib/main.dart'; // Importa MyApp

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleziona Lingua'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Cambia la lingua in Inglese
                Locale newLocale = Locale('en', 'US');
                MyApp.setLocale(context, newLocale);
              },
              child: Text('Inglese'),
            ),
            ElevatedButton(
              onPressed: () {
                // Cambia la lingua in Italiano
                Locale newLocale = Locale('it', 'IT');
                MyApp.setLocale(context, newLocale);
              },
              child: Text('Italiano'),
            ),
          ],
        ),
      ),
    );
  }
}
