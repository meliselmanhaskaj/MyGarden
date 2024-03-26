import 'dart:convert';

class Plant {
  Plant(
      {this.name,
      this.image,
      this.description,
      this.watering_frequency,
      this.species,
      this.propriety,
      this.estimated_growing_days});

  final String? name;
  final String? image;
  final String? description;
  final String? watering_frequency;
  final String? species;
  final String? propriety;
  final int? estimated_growing_days;

  Plant copyWith(
          {String? name,
          String? image,
          String? description,
          String? watering_frequency,
          String? species,
          String? propriety,
          int? estimated_growing_days}) =>
      Plant(
          name: name ?? this.name,
          image: image ?? this.image,
          description: description ?? this.description,
          watering_frequency: watering_frequency ?? this.watering_frequency,
          species: species ?? this.species,
          propriety: propriety ?? this.propriety,
          estimated_growing_days:
              estimated_growing_days ?? this.estimated_growing_days);
}