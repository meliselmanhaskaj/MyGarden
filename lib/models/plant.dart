import 'dart:convert';

class Plant {
  Plant({
    required this.common_name,
    required this.watering_frequency,
    required this.estimated_growing_days,
    required this.propriety
  });

  final String common_name;
  final String watering_frequency;
  final int estimated_growing_days;
  final String propriety;

}