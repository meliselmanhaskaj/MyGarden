import 'package:flutter/material.dart';
import '../services/event_service.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendar'),
        ),
        body: const Column(
          children: [
            CalendarEvent(),
          ],
        ));
  }
}
