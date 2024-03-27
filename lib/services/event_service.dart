import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CalendarEvent extends StatefulWidget {
  const CalendarEvent({Key? key});

  @override
  State<CalendarEvent> createState() => _CalendarEventState();
}

class _CalendarEventState extends State<CalendarEvent> {
  List<String> plants = [];

  @override
  void initState() {
    super.initState();
    loadPlants();
  }

  Future<void> loadPlants() async {
    final String jsonString =
        await rootBundle.loadString('../../data/userData.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    print("json di partenza : $jsonList");

    setState(() {
      plants = jsonList
          .map((item) => "Selected Name: ${item["selectedName"]}, "
              "Watering Frequency: ${item["watering_frequency"]}, "
              "Estimated Growing Days: ${item["estimated_growing_days"]}, "
              "Planted Day: ${item["planted_day"]}")
          .toList();
    });
    print("json di arrivo : $plants");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text("Json di arrivo: ${plants.toString()}"),
            ),
            if (plants.isNotEmpty) // Aggiungere questa condizione
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: plants.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(plants[index]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
