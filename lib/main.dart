import 'dart:convert';
import 'package:address_24/screens/my_plant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/plant.dart';
import 'screens/recipesadd_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Esempio di Barra di Navigazione Inferiore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  List<String> plants = [];
  List<dynamic> jsonList = [];

  @override
  void initState() {
    super.initState();
    loadPlants();
  }

  Future<void> loadPlants() async {
    final String jsonString =
        await rootBundle.loadString('data/userData.json');
    jsonList = json.decode(jsonString);
    plants = jsonList.map((item) => item.toString()).toList();
    setState(() {
      plants = jsonList.map((item) => item["selectedName"].toString()).toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 2) {
        // Se l'utente preme sull'icona delle Ricette (indice 2), apri la schermata principale delle Ricette
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipesMainScreen()),
        );
      }
    });
  }

  void _onPlantTapped(dynamic myPlant) {
    final Plant miaPianta = Plant.fromJson(myPlant);
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyPlant(plant: miaPianta)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('MyGarden - La migliore app per il management del tuo orto!'),
      ),
      body: ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(plants[index]),
            onTap: () => {
              _onPlantTapped(jsonList[index])
              },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.nature),
            label: 'My Garden',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Recipes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
