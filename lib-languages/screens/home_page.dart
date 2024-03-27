import 'package:flutter/material.dart';
import '../services/localization.dart';
import 'setting_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          // Testo tradotto in base alla lingua corrente
          AppLocalizations.of(context)!.translate('home_page_content'),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
