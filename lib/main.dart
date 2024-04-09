import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom navigation bar',
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
          selectedIconTheme: IconThemeData(
            color: Colors.green[500],
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
