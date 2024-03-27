import 'dart:io';
import 'package:address_24/models/plant.dart';
import 'package:flutter/material.dart';

//  ToDo:
//    -Caricamento dell'immagine
//    -Aggiungere i campi json (data di quando e stata piantata, quanto manca)
//    -Aggiungere un link al calendario
//    -Non fare i Tile statici pero mapparli con il metodo returnList()

class MyPlantWidget extends StatelessWidget {
  const MyPlantWidget({
      super.key, required this.p
    });

  final Plant p;

    // List<Widget> returnList() {
    //   final List<Widget> list = [];
    //   final namesList = ['Watering frequency', 'Estimated growing days', 'Propriety'];
    //   final jsonNames = ['wateringFrequency', 'estimated_growing_days', 'propriety'];

    //   for(int i = 0; i < namesList.length; i++) {
    //     final fieldName = jsonNames[i];
    //     final Widget obj = ListTile(
    //            leading: const Icon(Icons.water_drop_outlined),
    //            title: Text('${namesList[i]}: ${p[fieldName]}'),
    //          );

    //     list.add(obj); 
    //   }
    //   return list;
    // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image(image: AssetImage('data/assets/${p.common_name}.jpeg')),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.water_drop_outlined),
                  title: Text('Watering frequency: ${p.watering_frequency}'),
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: Text('Estimated growing days: ${p.estimated_growing_days}'),
                ),
                ListTile(
                  leading: const Icon(Icons.local_pizza),
                  title: Text('Propriety: ${p.propriety}'),
                ),
              ]
            ),
          )
        ],
      ),
    );
  }
}