import 'package:flutter/material.dart';

class RecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String recipeTitle = '';
    String recipeDetails = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        backgroundColor: Colors.green[500], // Colore personalizzato per la barra dell'app
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: ListView(
          children: [
            Column(
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
                    filled: true,
                    fillColor: Colors.grey[200], // Colore di riempimento per il campo di input
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
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
                    filled: true,
                    fillColor: Colors.grey[200], // Colore di riempimento per il campo di input
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Colore di sfondo del pulsante
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Colore del testo del pulsante
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 12.0), // Spaziatura interna del pulsante
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
