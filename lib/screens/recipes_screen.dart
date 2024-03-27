import 'package:flutter/material.dart';

class RecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String recipeTitle = '';
    String recipeDetails = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Aggiungi titolo ricetta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              onChanged: (value) {
                recipeTitle = value;
              },
              decoration: InputDecoration(
                hintText: 'Inserisci il titolo della ricetta',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Aggiungi ricetta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              onChanged: (value) {
                recipeDetails = value;
              },
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Inserisci la ricetta qui',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (recipeTitle.isNotEmpty && recipeDetails.isNotEmpty) {
                  // Solo se entrambi il titolo e i dettagli della ricetta sono stati inseriti
                  Navigator.pop(context, [recipeTitle, recipeDetails]);
                } else {
                  // Mostra un messaggio di avviso se uno dei campi è vuoto
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Si prega di compilare tutti i campi'),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
