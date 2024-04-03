import 'dart:convert';
import 'package:address_24/models/plant.dart';
import 'package:address_24/screens/my_plant.dart';
import 'package:address_24/screens/recipesadd_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:address_24/screens/camera.dart'; // Importiamo il file camera.dart

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
          unselectedItemColor: Colors.blue,
          backgroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyText1: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
      ),
      home: SplashScreen(), // Utilizzo dello SplashScreen come home iniziale
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    // Attendiamo 2 secondi e poi naviga alla HomePage
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icona o Logo dell'app
                Icon(
                  Icons.nature,
                  size: 100,
                  color: Colors.green[500],
                ),
                SizedBox(height: 20),
                // Nome dell'app nello SplashScreen
                Text(
                  'MY GARDEN',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[500],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
      plants = userPlantList.map((item) => item["selected_name"].toString()).toList();
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
      // Aggiungiamo l'opzione per navigare alla schermata Camera
      else if (_selectedIndex == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CameraScreen()),
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
    // Implementazione del pulsante "+" per aggiungere una pianta
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aggiungi Pianta'),
          content: Text('Qui ci sarà il form per aggiungere una nuova pianta.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annulla'),
            ),
            TextButton(
              onPressed: () {
                // Qui aggiungeremo il codice per salvare la nuova pianta
                Navigator.of(context).pop();
              },
              child: Text('Aggiungi'),
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
        title: Center(
          child: Text(
            'MY GARDEN', // Titolo personalizzato per la pagina Home
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
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
                print(plants);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('data/assets/${plant['common_name']}.jpeg'),
                      ),
                      title: Text(
                        plantName,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      trailing: CircleAvatar(
                        backgroundImage: AssetImage('data/assets/Icons/${plant['propriety']}.png'),
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
        child: Icon(Icons.add),
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
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt, size: 28),
              label: 'Camera',
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
