import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalendarEvent extends StatefulWidget {
  const CalendarEvent({Key? key});

  @override
  State<CalendarEvent> createState() => _CalendarEventState();
}

class _CalendarEventState extends State<CalendarEvent> {
  List<Map<String, dynamic>> plants = []; // Cambia il tipo della lista

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
      plants = jsonList.map((item) {
        DateTime harvestDate = calculateHarvestDate(item);
        return {
          "selectedName": item["selectedName"],
          "watering_frequency": item["watering_frequency"],
          "estimated_growing_days": item["estimated_growing_days"],
          "planted_day": item["planted_day"],
          "harvestDate": harvestDate,
        };
      }).toList();
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
            ),
            if (plants.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: plants.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nome: ${plants[index]["selectedName"]}"),
                          Text(
                              "Giorno di raccolta: ${plants[index]["harvestDate"]}")
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Funzione per calcolare la data di raccolta
  DateTime calculateHarvestDate(dynamic plantData) {
    List<String> parts = plantData["planted_day"].split('-');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    DateTime plantedDay = DateTime(year, month, day);
    int estimatedGrowingDays = plantData["estimated_growing_days"];
    DateTime harvestDate = plantedDay.add(Duration(days: estimatedGrowingDays));
    return harvestDate;
  }
}

//Funzione per calcolare i giorni di annaffiatura
List<DateTime> calculateWateringDays(
    DateTime plantedDay, String wateringFrequency, DateTime harvestDate) {
  List<DateTime> wateringDays = [];
  //utilizza RegExp per cercare un numero seguito dalla parola “giorni” all’interno della stringa wateringFrequency.
  //Se viene trovata una corrispondenza, verrà assegnata alla variabile match.
  //Ad esempio, se wateringFrequency fosse “Ogni 3 giorni”, match conterrà il valore “3”.
  RegExp frequencyRegExp = RegExp(r'(\d+) giorni');
  RegExpMatch? match = frequencyRegExp.firstMatch(wateringFrequency);
  if (match != null) {
    int daysInterval = int.parse(match.group(1)!);
    // Calcolo dei giorni di annaffiatura fino alla data di raccolta
    DateTime currentDate = plantedDay;
    while (currentDate.isBefore(harvestDate)) {
      //i giorni di annaffiatura vengono aggiunti alla lista wateringDays
      wateringDays.add(currentDate);
      currentDate = currentDate.add(Duration(days: daysInterval));
    }
  }
  print(wateringDays);
  return wateringDays;
}
