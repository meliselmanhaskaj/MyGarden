import 'package:address_24/models/plant.dart';
import 'package:flutter/material.dart';

//  ToDo:
//    -Caricamento dell'immagine
//    -Aggiungere i campi json (data di quando e stata piantata, quanto manca)
//    -Aggiungere un link al calendario
//    -Non fare i Tile statici pero mapparli con il metodo returnList() --> Parzialmente Fatto!

class MyPlantWidget extends StatelessWidget {
  const MyPlantWidget({
      super.key, required this.p
    });

  final Plant p;

    List<Widget> returnList() {
      final List<Widget> list = [];
      final namesList = ['Watering frequency', 'Estimated growing days', 'Propriety'];
      final jsonNames = ['wateringFrequency', 'estimated_growing_days', 'propriety'];

      for(int i = 0; i < namesList.length; i++) {
        final fieldName = jsonNames[i];
        final value = fieldName == 'estimated_growing_days'
        ? p.estimated_growing_days
        : fieldName == 'wateringFrequency'
            ? p.watering_frequency
            : fieldName == 'propriety'
                ? p.propriety
                : '';

        final Widget obj = ListTile(
               leading: const Icon(Icons.water_drop_outlined),
               title: Text('${namesList[i]}: $value'),
             );

        list.add(obj); 
      }
      return list;
    }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage('data/assets/${p.common_name}.jpeg')),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: returnList()
          ),
        )
      ],
    );
  }
}