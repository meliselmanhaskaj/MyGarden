import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Per la conversione da/verso JSON
import 'recipes_screen.dart';

class RecipesMainScreen extends StatefulWidget {
  @override
  _RecipesMainScreenState createState() => _RecipesMainScreenState();
}

class _RecipesMainScreenState extends State<RecipesMainScreen> {
  List<Map<String, String>> savedRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? recipesJson = prefs.getString('saved_recipes');

    if (recipesJson != null) {
      setState(() {
        savedRecipes = List<Map<String, String>>.from(
          json.decode(recipesJson).map((item) => Map<String, String>.from(item)),
        );
      });
    }
  }

  Future<void> _saveRecipes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_recipes', json.encode(savedRecipes));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        backgroundColor: Colors.green[500], // Colore personalizzato per la barra dell'app
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'MY RECIPES',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[500], // Colore personalizzato per il titolo
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: savedRecipes.length,
              itemBuilder: (context, index) {
                final recipe = savedRecipes[index];
                return Card(
                  elevation: 2, // Aggiunge una leggera ombra al card
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      recipe['title']!,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(
                            title: recipe['title']!,
                            details: recipe['details']!,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipesScreen(),
                      ),
                    ).then((value) {
                      if (value != null && value is List<String>) {
                        setState(() {
                          final newRecipe = {
                            'title': value[0],
                            'details': value[1],
                          };
                          savedRecipes.add(newRecipe);
                          _saveRecipes(); // Salva le ricette dopo l'aggiunta
                        });
                      }
                    });
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Colors.green[500], // Colore personalizzato per il pulsante "Add"
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeDetailScreen extends StatelessWidget {
  final String title;
  final String details;

  RecipeDetailScreen({
    required this.title,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green[500], // Colore personalizzato per la barra dell'app
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Titolo:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[500], // Colore personalizzato per il titolo
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Descrizione:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[500], // Colore personalizzato per il titolo
              ),
            ),
            SizedBox(height: 8),
            Text(
              details,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
