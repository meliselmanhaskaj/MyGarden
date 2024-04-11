import 'dart:convert';
import 'package:My_Garden/screens/calendar_screen.dart';
import 'package:My_Garden/screens/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'recipes_screen.dart';
import 'camera.dart';

class RecipesMainScreen extends StatefulWidget {
  const RecipesMainScreen({super.key});

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
          json
              .decode(recipesJson)
              .map((item) => Map<String, String>.from(item)),
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
          title: const Text('Delete Recipe'),
          content: const Text('Are you sure you want to delete this recipe?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete) {
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
        title: const Text(
          'RECIPES',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading:
            false, // Rimuove l'icona di default (freccia indietro)
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
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
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      recipe['title']!,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
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
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editRecipe(index),
                          iconSize: 20,
                          color: Colors.blue,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _confirmDeleteRecipe(index),
                          iconSize: 20,
                          color: Colors.blue,
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
                        builder: (context) => const RecipesScreen(),
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
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green[500],
      unselectedItemColor: Colors.blue,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedFontSize: 14.0,
      unselectedFontSize: 14.0,
      currentIndex: 2, // Index 2 for Recipes in this screen
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today, size: 28),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.nature, size: 28),
          label: 'My Garden',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book, size: 28),
          label: 'Recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt, size: 28),
          label: 'Camera',
        ),
      ],
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage1(events: [])),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipesMainScreen()),
        );
      } else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CameraScreen()),
        );
        // Do nothing as we are already on this screen
      }
    });
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
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              details,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
