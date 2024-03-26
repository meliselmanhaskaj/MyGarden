// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Plant {
  Plant({
    this.common_name,
      this.id,
      this.selected_name,
      this.image,
      this.description,
      this.watering_frequency,
      this.species,
      this.propriety,
      this.estimated_growing_days});

  final String? common_name;
  final String? selected_name;
  final String? id;
  final String? image;
  final String? description;
  final String? watering_frequency;
  final String? species;
  final String? propriety;
  final String? estimated_growing_days;



  Plant copyWith(
          {String? common_name,
          String? image,
          String? id,
          String? selected_name,
          String? description,
          String? watering_frequency,
          String? species,
          String? propriety,
          String? estimated_growing_days}) =>
      Plant(
          common_name: common_name ?? this.common_name,
          id: id ?? this.id,
          selected_name: selected_name ?? this.selected_name,
          image: image ?? this.image,
          description: description ?? this.description,
          watering_frequency: watering_frequency ?? this.watering_frequency,
          species: species ?? this.species,
          propriety: propriety ?? this.propriety,
          estimated_growing_days:
              estimated_growing_days ?? this.estimated_growing_days);


  // factory Plant.fromRawJson(String str) => Plant.fromJson(json.decode(str));

  // factory Plant.fromJson(Map<String, dynamic> json) => Plant(
  //       id: json["id"],
  //       common_name: json["common_name"],
  //       selected_name: json["selected_name"],
  //       image: json["image"],
  //       description: json["description"],
  //       watering_frequency: json["watering_frequency"],
  //       species: json["species"],
  //       propriety: json["propriety"],
  //       estimated_growing_days: json["estimated_growing_days"],
  //     );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'common_name': common_name,
      'selected_name': selected_name,
      'id': id,
      'image': image,
      'description': description,
      'watering_frequency': watering_frequency,
      'species': species,
      'propriety': propriety,
      'estimated_growing_days': estimated_growing_days,
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      common_name: map['common_name'] != null ? map['common_name'] as String : null,
      selected_name: map['selected_name'] != null ? map['selected_name'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      watering_frequency: map['watering_frequency'] != null ? map['watering_frequency'] as String : null,
      species: map['species'] != null ? map['species'] as String : null,
      propriety: map['propriety'] != null ? map['propriety'] as String : null,
      estimated_growing_days: map['estimated_growing_days'] != null ? map['estimated_growing_days'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plant.fromJson(String source) => Plant.fromMap(json.decode(source) as Map<String, dynamic>);
}
