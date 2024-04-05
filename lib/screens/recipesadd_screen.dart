import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<void> _confirmDeleteRecipe(int index) async {
    final bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Recipe'),
          content: Text('Are you sure you want to delete this recipe?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete != null && confirmDelete) {
      setState(() {
        savedRecipes.removeAt(index);
        _saveRecipes();
      });
    }
  }

  void _editRecipe(int index) {
    final recipeToEdit = savedRecipes[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipesScreen(
          initialRecipeTitle: recipeToEdit['title'],
          initialRecipeDetails: recipeToEdit['details'],
        ),
      ),
    ).then((updatedRecipe) {
      if (updatedRecipe != null && updatedRecipe is List<String>) {
        setState(() {
          savedRecipes[index]['title'] = updatedRecipe[0];
          savedRecipes[index]['details'] = updatedRecipe[1];
          _saveRecipes();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RECIPES',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'My recipes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
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
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      recipe['title']!,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black, // Cambia il colore del testo del titolo
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editRecipe(index),
                          iconSize: 20, // Imposta la dimensione dell'icona
                          color: Colors.blue, // Cambia il colore dell'icona
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _confirmDeleteRecipe(index),
                          iconSize: 20, // Imposta la dimensione dell'icona
                          color: Colors.blue, // Cambia il colore dell'icona
                        ),
                      ],
                    ),
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
                          _saveRecipes();
                        });
                      }
                    });
                  },
                  child: Icon(Icons.add),
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
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
                color: Colors.blue,
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
                color: Colors.blue,
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
