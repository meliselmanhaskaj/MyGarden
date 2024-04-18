import 'package:address_24/screens/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
// import 'screens/splash_screen.dart';

void main() {
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfiWeb;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Garden',
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
      home: const MyHomePage(),
    );
  }
}
