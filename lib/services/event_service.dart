import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalendarEvent extends StatefulWidget {
  const CalendarEvent({super.key});
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
    DateTime currentDate = DateTime.now();
    final String jsonString =
        await rootBundle.loadString('../../data/userData.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    setState(() {
      plants = jsonList.map((item) {
        DateTime harvestDate = calculateHarvestDate(item);
        int extractNumberFromString(String wateringFrequency) {
          RegExp regExp = RegExp(r'\b(\d+)\b');
          Match? match = regExp.firstMatch(wateringFrequency);
          int numero;
          if (match != null) {
            String numberAsString = match.group(0)!;
            numero = int.parse(numberAsString);
          } else {
            numero = 0;
            // In caso di mancata corrispondenza, restituisci un valore predefinito o gestisci l'eccezione di conseguenza
          }
          return numero;
        }

        int giorni = extractNumberFromString(item["watering_frequency"]);

        return {
          "selectedName": item["selectedName"],
          "watering_frequency": item["watering_frequency"],
          "estimated_growing_days": item["estimated_growing_days"],
          "planted_day": item["planted_day"],
          "harvestDate": harvestDate,
          "currentDate": currentDate,
          "giorni": giorni,
          // "wateringDays": calculateWateringDays(
          //     DateTime.parse(item["planted_day"]), giorni, harvestDate),
        };
      }).toList();
      // List<DateTime> calculateWateringDays(
      //     DateTime plantedDay, int giorni, DateTime harvestDate) {
      //   List<DateTime> wateringDays = [];
      //   DateTime currentDate = plantedDay;
      //   // Aggiungi i giorni di annaffiatura fino alla data di raccolta
      //   while (currentDate.isBefore(harvestDate)) {
      //     wateringDays.add(currentDate);
      //     currentDate = currentDate.add(Duration(days: giorni));
      //   }
      //   return wateringDays;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Oggi: ${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}'),
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
                    // List<DateTime> wateringDays = calculateWateringDays(
                    //     DateTime.parse(plants[index]["planted_day"]),
                    //     plants[index]["giorni"],
                    //     plants[index]["harvestDate"]);
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nome: ${plants[index]["selectedName"]}"),
                          Text(
                              "Giorno di raccolta: ${plants[index]["harvestDate"].toString().substring(0, 10)}"),
                          Text(
                              "Da annaffiare ogni: ${plants[index]["giorni"]} giorni"),
                          // Text(
                          //     "Giorni di annaffiatura: ${wateringDays.map((date) => date.toString().substring(0, 10)).toList()}"),
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

  //metodo per il giorno di raccolta
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
