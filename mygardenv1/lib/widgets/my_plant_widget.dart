import 'package:My_Garden/models/plant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyPlantWidget extends StatelessWidget {
  const MyPlantWidget({super.key, required this.p});

  final Plant p;

  List<Widget> returnList() {
    final List<Widget> list = [];
    final namesList = [
      'Watering frequency',
      'Estimated growing days',
      'Propriety',
      'Planted day',
      'Missing days'
    ];
    final List<IconData> iconsList = [
      Icons.water_drop_outlined,
      Icons.calendar_month,
      Icons.info,
      Icons.calendar_today_sharp,
      Icons.calendar_view_day
    ];

    for (int i = 0; i < namesList.length; i++) {
      final String fieldName = namesList[i];
      final int daysLeft = (DateFormat('dd-MM-yyyy')
              .parse(p.planted_day!)
              .add(Duration(days: p.estimated_growing_days!)))
          .difference(DateTime.now())
          .inDays;
      final value = fieldName == 'Estimated growing days'
          ? p.estimated_growing_days
          : fieldName == 'Watering frequency'
              ? p.watering_frequency
              : fieldName == 'Propriety'
                  ? p.propriety
                  : fieldName == 'Planted day'
                      ? p.planted_day
                      : fieldName == 'Missing days'
                          ? daysLeft >= 0
                              ? daysLeft
                              : 'Farming complete'
                          : '';

      final Widget obj = ListTile(
        leading: Icon(
          iconsList[i],
          color: const Color.fromRGBO(103, 148, 54, 1),
        ),
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
        Image(image: AssetImage('data/${p.image}')),
        Card(
          child: Column(mainAxisSize: MainAxisSize.min, children: returnList()),
        )
      ],
    );
  }
}
