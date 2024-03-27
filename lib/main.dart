import 'dart:convert';
import 'package:address_24/models/plant.dart';
import 'package:address_24/screens/my_plant.dart';
import 'package:address_24/screens/recipesadd_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Esempio di Barra di Navigazione Inferiore',
      theme: ThemeData(
        primaryColor: Colors.green[500],
        scaffoldBackgroundColor: Colors.green[50],
        appBarTheme: AppBarTheme(
          color: Colors.green[500],
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.green[500],
          unselectedItemColor: Colors.grey[600],
          backgroundColor: Colors.green[50],
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Colore del testo dell'AppBar
          ),
          bodyText1: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
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
    final String jsonString = await rootBundle.loadString('data/userData.json');
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
        _selectedIndex = 1;
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
        title: Text(
          'MyGarden',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              plants[index],
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () =>
                {print(jsonList[index]), _onPlantTapped(jsonList[index])},
          );
        },
      ),
    bottomNavigationBar: Container(
  decoration: BoxDecoration(
    border: Border(
      top: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    ),
  ),
  child: BottomNavigationBar(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.green[500],
    unselectedItemColor: Colors.blue,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedFontSize: 14.0,
    unselectedFontSize: 14.0,
    currentIndex: _selectedIndex,
    onTap: _onItemTapped,
    items: <BottomNavigationBarItem>[
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
    ],
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
    elevation: 8.0,
    type: BottomNavigationBarType.fixed,
  ),
),

    );
  }
}
