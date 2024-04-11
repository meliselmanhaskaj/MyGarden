import 'dart:convert';

class Event {
  //to every event -- singola cosa da fare
  Event({
    this.name,
    this.date,
    this.description,
  });

  final String? name;
  final String? date;
  final String? description;

  Event copyWith({
    String? name,
    String? date,
    String? description,
  }) =>
      Event(
        name: name ?? this.name,
        date: date ?? this.date,
        description: description ?? this.description,
      );

  factory Event.fromRawJson(String str) => Event.fromJson(json.decode(str));

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        name: json["name"],
        date: json["daysToHarvest"] == null ? null : json['daysToHarvest'],
        description: json["description"] == null ? null : json['description'],
      );
}
