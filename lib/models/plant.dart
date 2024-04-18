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

  String? common_name;
  String? selected_name;
  int? id;
  String? image;
  String? description;
  String? watering_frequency;
  String? species;
  String? propriety;
  String? planted_day;
  String? estimated_growing_days;

  Plant copyWith(
          {String? common_name,
          String? image,
          int? id,
          String? selected_name,
          String? description,
          String? watering_frequency,
          String? propriety,
          String? planted_day,
          String? estimated_growing_days}) =>
      Plant(
          common_name: common_name ?? this.common_name,
          id: id ?? this.id,
          selected_name: selected_name ?? this.selected_name,
          image: image ?? this.image,
          description: description ?? this.description,
          watering_frequency: watering_frequency ?? this.watering_frequency,
          propriety: propriety ?? this.propriety,
          planted_day: planted_day ?? this.planted_day,
          estimated_growing_days:
              estimated_growing_days ?? this.estimated_growing_days);

  factory Plant.fromRawJson(String str) => Plant.fromJson(json.decode(str));

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["id"],
        common_name: json["common_name"],
        selected_name: json["selected_name"],
        image: json["image"],
        description: json["description"],
        watering_frequency: json["watering_frequency"],
        propriety: json["propriety"],
        planted_day: json["planted_day"],
        estimated_growing_days: json["estimated_growing_days"],
      );

  Map<String, dynamic> toMap() {
    return {
      "common_name": common_name,
      "selected_name": selected_name,
      "id": id,
      "image": image,
      "description": description,
      "watering_frequency": watering_frequency,
      "propriety": propriety,
      "planted_day": planted_day,
      "estimated_growing_days": estimated_growing_days,
    };
  }

  factory Plant.fromMap(Map<dynamic, dynamic> map) {
    return Plant(
      common_name: map["common_name"],
      selected_name: map["selected_name"],
      id: map["id"],
      image: map["image"],
      description: map["description"],
      watering_frequency: map["watering_frequency"],
      propriety: map["propriety"],
      planted_day: map["planted_day"],
      estimated_growing_days: map["estimated_growing_days"],
    );
  }

  @override
  String toString() {
    return 'Plant(common_name: $common_name, selected_name: $selected_name, id: $id, image: $image, description: $description, watering_frequency: $watering_frequency, propriety: $propriety, planted_day: $planted_day, estimated_growing_days: $estimated_growing_days)';
  }

  String toJson() {
    return json.encode({
      "common_name": common_name,
      "selected_name": selected_name,
      "id": id,
      "image": image,
      "description": description,
      "watering_frequency": watering_frequency,
      "propriety": propriety,
      "planted_day": planted_day,
      "estimated_growing_days": estimated_growing_days,
    });
  }
}
