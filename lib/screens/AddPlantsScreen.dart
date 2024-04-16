// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:address_24/models/plant.dart';
import 'package:flutter/material.dart';

class AddPlantsScreen extends StatefulWidget {
  @override
  _AddPlantsScreenState createState() => _AddPlantsScreenState();
}

class _AddPlantsScreenState extends State<AddPlantsScreen> {
  final _formKey = GlobalKey<FormState>();

  String? id;
  String? selectedName;
  String? commonName;
  String? wateringFrequency;
  String? description;
  String? estimatedGrowingDays;
  String? plantedDay;
  String? propriety;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Plants',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome Pianta'),
                onSaved: (value) => selectedName = value,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Scegli pianta'),
                value: commonName,
                onChanged: (value) {
                  setState(() {
                    commonName = value;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'Lettuce',
                    child: Text('Lettuce'),
                  ),
                  DropdownMenuItem(
                    value: 'Tomato',
                    child: Text('Tomato'),
                  ),
                  DropdownMenuItem(
                    value: 'Basil',
                    child: Text('Basil'),
                  ),
                  DropdownMenuItem(
                    value: 'Hawthorn',
                    child: const Text('Hawthorn'),
                  ),
                  DropdownMenuItem(
                    value: 'Marigold',
                    child: Text('Marigold'),
                  ),
                  DropdownMenuItem(
                    value: 'Hyacinth',
                    child: Text('Hyacinth'),
                  ),
                  DropdownMenuItem(
                    value: 'Orchid',
                    child: Text('Orchid'),
                  ),
                  DropdownMenuItem(
                    value: 'Rose',
                    child: Text('Rose'),
                  ),
                ],
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Watering Frequency'),
                value: wateringFrequency,
                onChanged: (value) {
                  setState(() {
                    wateringFrequency = value;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'Every 1 days',
                    child: Text('giornalmente'),
                  ),
                  DropdownMenuItem(
                    value: 'Every 2 days',
                    child: Text('ogni 2 giorni'),
                  ),
                  DropdownMenuItem(
                    value: 'Every 3 days',
                    child: Text('ogni 3 giorni'),
                  ),
                  DropdownMenuItem(
                    value: 'Every 4 days',
                    child: Text('ogni 4 giorni'),
                  ),
                ],
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Giorni di crescita stimati'),
                onSaved: (value) => estimatedGrowingDays = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  _formKey.currentState!.save();
                  final plantres = Plant(
                    id: 7,
                    selectedName: selectedName,
                    common_name: commonName,
                    watering_frequency: wateringFrequency,
                    description: description,
                    estimated_growing_days: int.parse(estimatedGrowingDays!),
                    planted_day: DateTime.now().toString(),
                    propriety: "null",
                    image: "null",
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Result'),
                        content: Text(plantres.toString()),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Aggiungi Pianta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
