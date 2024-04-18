import 'package:address_24/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    String path = '../../data/plant.db';
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
  // {
  //       "id" : 0,
  //       "selected_name" : "Lettuce - terrace",
  //       "common_name" : "Lettuce",
  //       "watering_frequency" : "Every 2 days",
  //       "description" : "The lettuce is an annual plant...",
  //       "estimated_growing_days" : 45,
  //       "planted_day" : "26-03-2024",
  //       "image": "assets/Lettuce.jpeg",
  //       "propriety": "edible"
  //   },

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Plants (id INTEGER, selected_name TEXT, common_name TEXT, watering_frequency TEXT, description TEXT, estimated_growing_days TEXT, planted_day TEXT, image TEXT,  propriety TEXT)');
  }

  Future<void> add(Plant plant) async {
    try {
      var dbClient = await db;
      plant.id = await dbClient?.insert('Plants', plant.toMap());
    } catch (e) {
      // Handle the error here
      print('Error inserting plant: $e');
    }
  }

  Future<List<Plant>> getPlants() async {
    var dbClient = await db;
    List<Map> maps = await dbClient!.query('Plants', columns: [
      'id',
      'selected_name',
      'common_name',
      'watering_frequency',
      'description',
      'estimated_growing_days',
      'planted_day',
      'image',
      'propriety'
    ]);
    List<Plant> students = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        students.add(Plant.fromMap(maps[i]));
      }
    }
    return students;
  }

  Future<int> delete(int id) async {
    try {
      var dbClient = await db;
      return await dbClient!.delete(
        'Plants',
        where: 'id = $id',
      );
    } catch (e) {
      // Handle the error here
      print('Error deleting plant: $e');
      return 0; // Return 0 to indicate failure
    }
  }

  Future close() async {
    var dbClient = await db;
    dbClient?.close();
  }
}
