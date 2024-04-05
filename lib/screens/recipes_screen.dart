import 'package:flutter/material.dart';

class RecipesScreen extends StatefulWidget {
  final String? initialRecipeTitle;
  final String? initialRecipeDetails;

  RecipesScreen({this.initialRecipeTitle, this.initialRecipeDetails});

  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  late TextEditingController _titleController;
  late TextEditingController _detailsController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialRecipeTitle);
    _detailsController = TextEditingController(text: widget.initialRecipeDetails);
  }

  void _saveRecipe() {
    final recipeTitle = _titleController.text;
    final recipeDetails = _detailsController.text;

    if (recipeTitle.isNotEmpty && recipeDetails.isNotEmpty) {
      print('Title: $recipeTitle');
      print('Details: $recipeDetails');

      Navigator.pop(context, [recipeTitle, recipeDetails]);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipes',
          style: TextStyle(
            color: Colors.white, // Titolo della barra superiore in bianco
          ),
        ),
        backgroundColor: Colors.green[500],
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
                    color: Colors.blue, // Parola "Titolo" in blu
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _titleController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: TextStyle(
                    color: Colors.black, // Testo nero per il campo titolo
                  ),
                  decoration: InputDecoration(
                    hintText: 'Inserisci il titolo della ricetta',
                    filled: true,
                    fillColor: Colors.grey[200],
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
                    color: Colors.blue, // Parola "Descrizione delle ricette" in blu
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _detailsController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  maxLines: 5,
                  style: TextStyle(
                    color: Colors.black, // Testo nero per il campo descrizione
                  ),
                  decoration: InputDecoration(
                    hintText: 'Inserisci la ricetta qui',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _saveRecipe,
                  child: Text('Salva Ricetta'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey; // Colore quando il pulsante è disabilitato
                      }
                      return Colors.green; // Colore quando il pulsante è abilitato
                    }),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 12.0),
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

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }
}
