// ignore_for_file: non_constant_identifier_names

//import 'dart:convert';

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
      this.estimated_growing_days});

  final String? common_name;
  final String? selected_name;
  final int? id;
  final String? image;
  final String? description;
  final String? watering_frequency;
  final String? species;
  final String? propriety;
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
          estimated_growing_days:
              estimated_growing_days ?? this.estimated_growing_days);
}

//   factory Person.fromRawJson(String str) => Person.fromJson(json.decode(str));

//   factory Person.fromJson(Map<String, dynamic> json) => Person(
//         gender: json["gender"],
//         firstName: json["name"] == null ? null : json['name']['first'],
//         lastName: json["name"] == null ? null : json['name']['last'],
//         email: json["email"],
//         cell: json["cell"],
//         id: json["id"] == null ? null : json['id']['value'],
//         picture:
//             json["picture"] == null ? null : Picture.fromJson(json["picture"]),
//       );
// }
