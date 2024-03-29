import 'dart:convert';


class Plant {
  Plant(
      {this.common_name,
      this.id,
      this.selected_name,
      this.image,
      this.description,
      this.watering_frequency,
      this.species,
      this.propriety,
      this.planted_day,
      this.estimated_growing_days});

  final String? common_name;
  final String? selected_name;
  final int? id;
  final String? image;
  final String? description;
  final String? watering_frequency;
  final String? species;
  final String? propriety;
  final String? planted_day;
  final int? estimated_growing_days;

  Plant copyWith(
          {String? common_name,
          String? image,
          int? id,
          String? selected_name,
          String? description,
          String? watering_frequency,
          String? species,
          String? propriety,
          String? planted_day,
          int? estimated_growing_days}) =>
      Plant(
          common_name: common_name ?? this.common_name,
          id: id ?? this.id,
          selected_name: selected_name ?? this.selected_name,
          image: image ?? this.image,
          description: description ?? this.description,
          watering_frequency: watering_frequency ?? this.watering_frequency,
          species: species ?? this.species,
          propriety: propriety ?? this.propriety,
          planted_day: planted_day ?? this.planted_day,
          estimated_growing_days:
              estimated_growing_days ?? this.estimated_growing_days);

  factory Plant.fromRawJson(String str) => Plant.fromJson(json.decode(str));

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["id"],
        common_name: json["common_name"],
        selected_name: json["selectedName"],
        image: json["image"],
        description: json["description"],
        watering_frequency: json["watering_frequency"],
        species: json["species"],
        propriety: json["propriety"],
        planted_day: json["planted_day"],
        estimated_growing_days: json["estimated_growing_days"],
      );
}
