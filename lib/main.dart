import 'package:address_24/models/plant.dart';
import 'package:address_24/screens/my_plant.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Bar Example',
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
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final myPlant = Plant(
    id: '1',
    selected_name: 'Lattuga - in terrazzo',
    common_name: "Lattuga",
    image: "assets/plant_lattuga.jpg",
    description: "La lattuga è una pianta erbacea annuale...",
    watering_frequency: "Ogni 2 giorni",
    species: "Lactuca sativa",
    propriety: "edible",
    estimated_growing_days: '30'
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Bar Example'),
      ),
      body: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
               builder: (context) {
                 return MyPlant(plant: myPlant);
               } 
             ));
          },
          child: Text('This is screen ${_selectedIndex + 1}'),
        ),
      ),
      // Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) {
      //           return PersonScreen(p: p);
      //         } 
      //       ));
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
