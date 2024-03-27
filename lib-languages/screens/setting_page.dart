import 'package:flutter/material.dart';
import 'language_page.dart';
import '../services/localization.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Impostazioni'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguagePage()),
                );
              },
              child: Text(
                // Testo tradotto in base alla lingua corrente
                AppLocalizations.of(context)!.translate('settings_page_button'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
