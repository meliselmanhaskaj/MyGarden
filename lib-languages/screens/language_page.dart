import 'package:flutter/material.dart';
import '../main.dart';
import '../services/localization.dart';

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
