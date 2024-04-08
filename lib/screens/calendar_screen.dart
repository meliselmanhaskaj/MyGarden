import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  });
}

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({Key? key}) : super(key: key);

  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  late MeetingDataSource dataSource;
  List<CalendarEvent> events = [];

  @override
  void initState() {
    super.initState();
    dataSource = MeetingDataSource([]);
    loadPlants();
  }

  Future<void> loadPlants() async {
    final jsonString = await rootBundle.loadString("/data/userData.json");
    final List<dynamic> jsonList = jsonDecode(jsonString);

    for (var item in jsonList) {
      DateTime harvestDate = calculateHarvestDate(item);
      int giorni = extractNumberFromString(item["watering_frequency"]);
      List<DateTime> wateringDays = await loadWatering(
          DateTime.parse(item["planted_day"]), giorni, harvestDate);

      List<CalendarEvent> _getDataSource() {
        final List<CalendarEvent> meetings = <CalendarEvent>[];

        meetings.add(CalendarEvent(
          eventName: "Planting: ${item["selectedName"]}",
          from: DateTime.parse(item["planted_day"]),
          to: DateTime.parse(item["planted_day"]),
          background: Colors.green,
        ));

        for (var wateringDay in wateringDays) {
          meetings.add(CalendarEvent(
            eventName: "Watering: ${item["selectedName"]}",
            from: wateringDay,
            to: wateringDay,
            background: Colors.blue,
          ));
        }
        return meetings;
      }

      events.addAll(_getDataSource());
    }
    setState(() {
      dataSource = MeetingDataSource(events);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Event'),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: dataSource,
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
      ),
    );
  }
}

//metodo per convertire numero da string ad int
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

//metodo per calcolare data raccolta
DateTime calculateHarvestDate(dynamic plantData) {
  List<String> parts = plantData["planted_day"].split('-');
  int day = int.parse(parts[2]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[0]);
  DateTime plantedDay = DateTime(year, month, day);
  int estimatedGrowingDays = plantData["estimated_growing_days"];
  DateTime harvestDate = plantedDay.add(Duration(days: estimatedGrowingDays));
  return harvestDate;
}

//lista che visualizzi giorni di annaffiamento
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
  final List<CalendarEvent> events;
  MeetingDataSource(this.events);
  //metodo con data inizio
  @override
  DateTime getStartTime(int index) {
    return events[index].from;
  }

  //metodo con data fine
  @override
  DateTime getEndTime(int index) {
    return events[index].to;
  }

  //metodo che restituisce il titolo dell'evento all'indice specificato
  @override
  String getSubject(int index) {
    return events[index].eventName;
  }

  //metodo che restituisce colore di sfondo dell'evento specificato
  @override
  Color getColor(int index) {
    return events[index].background;
  }

  //metodo che divide eventi tra tutto il giorno  o in un determinato orario
  @override
  bool isAllDay(int index) {
    return false;
  }
}
