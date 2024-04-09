import 'dart:convert';
import 'package:address_24/models/plant.dart';
import 'package:address_24/screens/calendar_screen.dart';
import 'package:address_24/screens/camera.dart';
import 'package:address_24/screens/my_plant.dart';
import 'package:address_24/screens/recipesadd_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;
  List<String> plants = [];
  List<dynamic> userPlantList = [];

  @override
  void initState() {
    super.initState();
    loadPlants();
  }

  Future<void> loadPlants() async {
    final String jsonString = await rootBundle.loadString('data/userData.json');
    userPlantList = json.decode(jsonString);
    setState(() {
      plants = userPlantList
          .map((item) => item["selected_name"].toString())
          .toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        // Se l'utente preme sull'icona del calendario (indice ), apri la schermata del calendario
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const MyHomePage1(events: [])), //collegamento con calendar
        );
      }
      if (_selectedIndex == 1) {
        // // Se l'utente preme sull'icona del calendario (indice 1), apri la schermata principale
      }
      if (_selectedIndex == 2) {
        _selectedIndex = 1;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipesMainScreen()),
        );
      } else if (_selectedIndex == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CameraScreen()),
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

  void _onAddPlant() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Aggiungi Pianta'),
          content: const Text(
              'Qui ci sarà il form per aggiungere una nuova pianta.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annulla'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aggiungi'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'MY GARDEN',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        automaticallyImplyLeading:
            false, // Rimuove l'icona di default (freccia indietro)
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            'My Plants',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue[500],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                final plantName = plants[index];
                final plant = userPlantList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'data/assets/${plant['common_name']}.jpeg'),
                      ),
                      title: Text(
                        plantName,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      trailing: CircleAvatar(
                        backgroundImage: AssetImage(
                            'data/assets/Icons/${plant['propriety']}.png'),
                        backgroundColor: Colors.white,
                      ),
                      onTap: () => _onPlantTapped(userPlantList[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddPlant,
        child: const Icon(Icons.add),
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
      currentIndex: _selectedIndex,
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
}
