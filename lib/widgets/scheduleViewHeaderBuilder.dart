import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

String _getMonthName(int month) {
  if (month == 1) {
    return 'January';
  } else if (month == 2) {
    return 'February';
  } else if (month == 3) {
    return 'March';
  } else if (month == 4) {
    return 'April';
  } else if (month == 5) {
    return 'May';
  } else if (month == 6) {
    return 'June';
  } else if (month == 7) {
    return 'July';
  } else if (month == 8) {
    return 'August';
  } else if (month == 9) {
    return 'September';
  } else if (month == 10) {
    return 'October';
  } else if (month == 11) {
    return 'November';
  } else {
    return 'December';
  }
}

Widget scheduleViewHeaderBuilder(
    BuildContext buildContext, ScheduleViewMonthHeaderDetails details) {
  final String monthName = _getMonthName(details.date.month);
  return Stack(
    children: [
      Image(
        image: ExactAssetImage('images/' + monthName + '.png'),
        fit: BoxFit.cover,
        width: details.bounds.width,
        height: details.bounds.height,
      ),
      Positioned(
        left: 55,
        right: 0,
        top: 20,
        bottom: 0,
        child: Text(
          monthName + ' ' + details.date.year.toString(),
          style: const TextStyle(fontSize: 18),
        ),
      )
    ],
  );
}
