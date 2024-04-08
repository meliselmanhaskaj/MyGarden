import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarEvent {
  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;

  CalendarEvent({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required TextStyle textStyle,
  });
}

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({super.key, required this.events});
  final List<CalendarEvent> events;

  @override
  MyHomePage1State createState() => MyHomePage1State();
}

class MyHomePage1State extends State<MyHomePage1> {
  late MeetingDataSource dataSource = MeetingDataSource([]);
  List<CalendarEvent> events = [];

  @override
  void initState() {
    super.initState();
  }

  Future<MeetingDataSource> loadPlants() async {
    final jsonString = await rootBundle.loadString("data/userData.json");
    final List<dynamic> jsonList = jsonDecode(jsonString);

    for (var item in jsonList) {
      DateTime harvestDate = calculateHarvestDate(item);
      int giorni = extractNumberFromString(item["watering_frequency"]);
      List<DateTime> wateringDays = await loadWatering(
          DateFormat('dd-MM-yyyy').parse(item["planted_day"]),
          giorni,
          harvestDate);

      List<CalendarEvent> getDataSource() {
        final List<CalendarEvent> meetings = <CalendarEvent>[];

        meetings.add(CalendarEvent(
            eventName: "Planting: ${item["selected_name"]}",
            from: DateFormat('dd-MM-yyyy').parse(item["planted_day"]),
            to: DateFormat('dd-MM-yyyy').parse(item["planted_day"]),
            background: Colors.green,
            textStyle: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            )));
        meetings.add(CalendarEvent(
          eventName: "Harvest: ${item["selected_name"]}",
          from: harvestDate,
          to: harvestDate,
          background: Colors.green,
          textStyle: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ));
        for (var wateringDay in wateringDays) {
          meetings.add(
            CalendarEvent(
              eventName: "Watering: ${item["selected_name"]}",
              from: wateringDay,
              to: wateringDay,
              background: Colors.blue,
              textStyle: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return meetings;
      }

      events.addAll(getDataSource());
    }

    return MeetingDataSource(events);
  }

//widget visuale
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calendar Event',
            style: TextStyle(
              color: Colors.white, // Imposta il colore del testo in bianco
              fontWeight:
                  FontWeight.bold, // Opzionale: aggiunge il grassetto al testo
              fontSize: 20, // Opzionale: imposta la dimensione del testo
            ),
          ),
          centerTitle: true, // Centra il titolo dell'app Bar
        ),
        body: FutureBuilder<MeetingDataSource>(
            future: loadPlants(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SfCalendar(
                  view: CalendarView.schedule,
                  dataSource: snapshot.data,
                  monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                  ),
                );
              }
            }));
  }
}

//metodo per convertire numero da string ad int V
int extractNumberFromString(String wateringFrequency) {
  RegExp regExp = RegExp(r'\b(\d+)\b');
  Match? match = regExp.firstMatch(wateringFrequency);
  int numero;
  if (match != null) {
    String numberAsString = match.group(0)!;
    numero = int.parse(numberAsString);
  } else {
    numero = 0;
  }
  return numero;
}

//metodo per calcolare data raccolta V
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

//lista che visualizzi giorni di annaffiamento V
Future<List<DateTime>> loadWatering(
    DateTime plantedDay, int giorni, DateTime harvestDate) async {
  List<DateTime> wateringDays = [];
  DateTime indexDate = plantedDay;
  while (indexDate.isBefore(harvestDate)) {
    wateringDays.add(indexDate);
    indexDate = indexDate.add(Duration(days: giorni));
  }
  return wateringDays;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<CalendarEvent> events) {
    appointments = events;
  }

  //metodo con data inizio
  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  //metodo con data fine
  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  //metodo con titolo evento
  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  //metodo con colore di sfondo dell'evento
  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  //metodo che divide gli eventi giornalieri o di un determinato orario
  @override
  bool isAllDay(int index) {
    return true;
  }
}
