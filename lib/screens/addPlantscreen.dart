import 'package:address_24/models/models.dart';
import 'package:address_24/models/plant.dart';
import 'package:address_24/screens/my_home_page.dart';
import 'package:address_24/services/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddPlantsScreen extends StatefulWidget {
  const AddPlantsScreen({super.key});

  @override
  _AddPlantsScreenState createState() => _AddPlantsScreenState();
}

class _AddPlantsScreenState extends State<AddPlantsScreen> {
  // List<dynamic> userPlantList = [];
  // dynamic plantsInfo = [];

  // File userdataFile = File('data/userData.json');

  // late final SharedPreferences prefs;

  // late final Database database;
  List<Plant>? userPlants;

  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  String common_name = '';
  String selected_name = '';
  int id = 0;
  String description = '';
  String watering_frequency = '';
  String species = '';
  String propriety = '';
  String planted_day = '';
  String estimated_growing_days = '';

  late DBHelper dbHelper;

  @override
  void initState() {
    super.initState();
    try {
      dbHelper = DBHelper();
      refreshPlantsList();
    } catch (e) {
      print('Error2: $e');
    }
  }

  refreshPlantsList() async {
    try {
      var temp = await dbHelper.getPlants();
      setState(() {
        userPlants = temp;
      });
    } catch (e) {
      print('Error1: $e');
    }
  }

  getLastId() {
    int maxId = 0;
    if (userPlants != null) {
      for (Plant plant in userPlants!) {
        if (plant.id! > maxId) {
          maxId = plant.id!;
        }
      }
    }
    int nextId = maxId + 1;
    return nextId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formStateKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Common Name'),
                initialValue: common_name,
                readOnly: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Select Common Name'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('Rose'),
                                onTap: () {
                                  setState(() {
                                    common_name = 'Rose';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Orchid'),
                                onTap: () {
                                  setState(() {
                                    common_name = 'Orchid';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Hyacinth'),
                                onTap: () {
                                  setState(() {
                                    common_name = 'Hyacinth';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Chamomile'),
                                onTap: () {
                                  setState(() {
                                    common_name = 'Chamomile';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Marigold'),
                                onTap: () {
                                  setState(() {
                                    common_name = 'Marigold';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Hawthorn'),
                                onTap: () {
                                  setState(() {
                                    common_name = 'Hawthorn';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Basil'),
                                onTap: () {
                                  setState(() {
                                    common_name = 'Basil';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Tomato'),
                                onTap: () {
                                  setState(() {
                                    common_name = 'Tomato';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('Lettuce'),
                                onTap: () {
                                  setState(() {
                                    common_name = 'Lettuce';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Selected Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a selected name';
                  }
                  return null;
                },
                onSaved: (value) {
                  selected_name = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Watering frequency'),
                initialValue: common_name,
                readOnly: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('select frequency'),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('daily'),
                                onTap: () {
                                  setState(() {
                                    watering_frequency = 'every 1 days';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('every 2 days'),
                                onTap: () {
                                  setState(() {
                                    watering_frequency = 'every 2 days';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('every 3 days'),
                                onTap: () {
                                  setState(() {
                                    watering_frequency = 'every 3 days';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: const Text('every 4 days'),
                                onTap: () {
                                  setState(() {
                                    watering_frequency = 'every 4 days';
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Estimated Growing Days'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the estimated growing days';
                  }
                  return null;
                },
                onSaved: (value) {
                  estimated_growing_days = value!;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formStateKey.currentState!.validate()) {
                    _formStateKey.currentState!.save();
                    String newPropriety;
                    // Cambia la proprietà in base al common_name selezionato
                    switch (common_name) {
                      case 'Rose':
                        newPropriety = 'flower';
                        break;
                      case 'Orchid':
                        newPropriety = 'flower';
                        break;
                      case 'Hyacinth':
                        newPropriety = 'flower';
                        break;
                      case 'Chamomile':
                        newPropriety = 'medicine';
                        break;
                      case 'Marigold':
                        newPropriety = 'medicine';
                        break;
                      case 'Hawthorn':
                        newPropriety = 'medicine';
                        break;
                      case 'Basil':
                        newPropriety = 'edible';
                        break;
                      case 'Tomato':
                        newPropriety = 'edible';
                        break;
                      case 'Lettuce':
                        newPropriety = 'edible';
                        break;
                      default:
                        newPropriety =
                            ''; // Imposta un valore predefinito o gestisci altri casi
                    }
                    // Create a new Plant object with the entered values
                    Plant newPlant = Plant(
                      id: getLastId(),
                      common_name: common_name,
                      selected_name: selected_name,
                      description: description,
                      watering_frequency: watering_frequency,
                      propriety:
                          newPropriety, // Assegna la nuova proprietà calcolata
                      planted_day:
                          DateFormat('dd-MM-yyyy').format(DateTime.now()),
                      estimated_growing_days: estimated_growing_days,
                      image: 'assets/$common_name.jpeg',
                    );
                    try {
                      dbHelper.add(newPlant);
                      refreshPlantsList();
                    } catch (e) {
                      print('Error: $e');
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  }
                },
                child: const Text('Add Plant'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

    //OLD CODE TO BROWSE INTO
    //   appBar: AppBar(
    //     title: Text('Add Plant'),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         ListView.builder(
    //           itemCount: userPlants?.length ?? 0,
    //           itemBuilder: (context, index) {
    //             Plant plant = userPlants![index];
    //             return Text(plant.toString());
    //           },
    //           scrollDirection: Axis.vertical,
    //           shrinkWrap: true,
    //         ),
    //         // Text(plantsInfo.toString()),
    //         ElevatedButton(
    //             onPressed: () {
    //               Plant a = Plant(
    //                   id: 777,
    //                   selected_name: 'Lettuce - terrace',
    //                   common_name: 'Lettuce',
    //                   watering_frequency: 'Every 2 days',
    //                   description: 'The lettuce is an annual plant...',
    //                   estimated_growing_days: '45',
    //                   planted_day: '26-03-2024',
    //                   image: 'assets/Lettuce.jpeg',
    //                   propriety: 'edible');

    //               try {
    //                 dbHelper.delete(777);
    //                 refreshPlantsList();
    //               } catch (e) {
    //                 print('Error: $e');
    //               }
    //             },
    //             child: const Text('Add Customer')),
    //       ],
    //     ),
    //   ),
    // );