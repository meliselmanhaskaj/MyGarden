import 'dart:convert';

import 'package:http/http.dart' as http;
const stringUrlJoke = "https://pixabay.com/api/?key=43357387-036b030016ea6e96dd4f0b923&q=";

dynamic getPlantImage(String plantName) async {
  
  String stringUrl = stringUrlJoke + plantName.replaceAll(' ', '+');

  final url = Uri.parse(stringUrl);
  final res = await http.get(url);
  final data = json.decode(res.body);

  String plantUrl;

  try {
    plantUrl= data['hits'][0]['previewURL'];
  } catch (e) {
    print(e);
    plantUrl = 'https://cdn.pixabay.com/photo/2019/07/15/23/51/magnifying-4340698_150.jpg';
  } 

  print('IMMAGINE PIANTA $plantUrl');

  return plantUrl;
}