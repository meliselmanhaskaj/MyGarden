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
      final namesList = ['Watering frequency', 'Estimated growing days', 'Propriety', 'Planted day', 'Missing days'];
      final jsonNames = ['wateringFrequency', 'estimated_growing_days', 'propriety', 'planted_day', 'estimated_growing_days'];
      final List<IconData> iconsList = [Icons.water_drop_outlined, Icons.calendar_month, Icons.info, Icons.calendar_today_sharp, Icons.calendar_view_day];

      for(int i = 0; i < namesList.length; i++) {
        final fieldName = namesList[i];
        final value = fieldName == 'Estimated growing days'
        ? p.estimated_growing_days
        : fieldName == 'Watering frequency'
            ? p.watering_frequency
            : fieldName == 'Propriety'
                ? p.propriety
                : fieldName == 'Planted day'
                  ? p.planted_day
                  : fieldName == 'Missing days'
                    ? p.estimated_growing_days
                    : '';

        final Widget obj = ListTile(
               leading: Icon(iconsList[i]),
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