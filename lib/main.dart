import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:address_24/screens/recipes_screen.dart';
import 'package:address_24/screens/recipesadd_screen.dart';
import 'package:address_24/screens/calendar_screen.dart';

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
      home: SafeArea(child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        // Se l'utente preme sull'icona del calendario (indice ), apri la schermata del calendario
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyHomePage1(events: [])), //collegamento con calendar
        );
      }
      if (_selectedIndex == 1) {
        // // Se l'utente preme sull'icona del calendario (indice 1), apri la schermata principale
      }
      if (_selectedIndex == 2) {
        // Se l'utente preme sull'icona delle Ricette (indice 2), apri la schermata principale delle Ricette
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipesMainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Esempio di Barra di Navigazione Inferiore'),
      ),
      body: Center(
        child: Text(
          'Questa è la schermata ${_selectedIndex + 1}',
          style: const TextStyle(fontSize: 24.0),
        ),
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
