import 'dart:convert';
import 'package:My_Garden/widgets/scheduleViewHeaderBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'my_home_page.dart';
import 'package:My_Garden/screens/camera.dart';
import 'package:My_Garden/screens/recipesadd_screen.dart';

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
  const MyHomePage1({Key? key, required this.events}) : super(key: key);
  final List<CalendarEvent> events;

  @override
  MyHomePage1State createState() => MyHomePage1State();
}

class MyHomePage1State extends State<MyHomePage1> {
  late MeetingDataSource dataSource = MeetingDataSource([]);
  List<CalendarEvent> events = [];
  int _selectedIndex = 0; // Indice iniziale

  @override
  void initState() {
    super.initState();
  }

  Future<MeetingDataSource> loadPlants() async {
    final jsonString = await rootBundle.loadString("data/userData.json");
    final List<dynamic> jsonList = jsonDecode(jsonString);
    List<CalendarEvent> events = [];
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
          ),
        ));
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
          meetings.add(CalendarEvent(
            eventName: "Watering: ${item["selected_name"]}",
            from: wateringDay,
            to: wateringDay,
            background: Colors.blue,
            textStyle: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ));
        }
        return meetings;
      }

      events.addAll(getDataSource());
    }
    return MeetingDataSource(events);
  }

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
            fontSize: 24, // Opzionale: imposta la dimensione del testo
          ),
        ),
        centerTitle: true, // Centra il titolo dell'app Bar
        automaticallyImplyLeading: false, // Rimuove la freccia dalla AppBar
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
              scheduleViewMonthHeaderBuilder: scheduleViewHeaderBuilder,
              scheduleViewSettings: const ScheduleViewSettings(
                  monthHeaderSettings: MonthHeaderSettings(
                      monthFormat: 'MMMM, yyyy',
                      height: 100,
                      textAlign: TextAlign.left,
                      backgroundColor: Colors.green,
                      monthTextStyle: TextStyle(
                          color: Color.fromARGB(255, 229, 229, 229),
                          fontSize: 25,
                          fontWeight: FontWeight.w400))),
              dataSource: snapshot.data,
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
              headerStyle: const CalendarHeaderStyle(
                textStyle: TextStyle(
                    color: Colors.black), // Personalizza lo stile del testo
                textAlign: TextAlign.center, // Centra il testo
                backgroundColor: Colors
                    .white, // Personalizza il colore dello sfondo dell'intestazione
              ),
            );
          }
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green[500],
      unselectedItemColor: Colors.blue,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedFontSize: 14.0,
      unselectedFontSize: 14.0,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today, size: 28),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.nature, size: 28),
          label: 'My Garden',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book, size: 28),
          label: 'Recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt, size: 28),
          label: 'Camera',
        ),
      ],
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage1(events: [])),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipesMainScreen()),
        );
      } else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CameraScreen()),
        );
      }

      // Imposta l'indice corretto quando si seleziona un'icona diversa
      _selectedIndex = index;
    });
  }

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
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<CalendarEvent> events) {
    appointments = events;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return true;
  }
}
