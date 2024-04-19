// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:address_24/models/plant.dart';
import 'package:address_24/screens/create_plant_form.dart';
import 'package:flutter/material.dart';

class AddPlantsScreen extends StatefulWidget {
  @override
  _AddPlantsScreenState createState() => _AddPlantsScreenState();
}

class _AddPlantsScreenState extends State<AddPlantsScreen> {
  final _formKey = GlobalKey<FormState>();

  String? id;
  String? selectedName;
  String? commonName;
  String? wateringFrequency;
  String? description;
  String? estimatedGrowingDays;
  String? plantedDay;
  String? propriety;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Plants',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: CreatePlantForm()
      );
  }
}

class DropdownFormField extends StatelessWidget {
  final String? labelText;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final List<String>? items;

  const DropdownFormField({
    Key? key,
    this.labelText,
    this.value,
    this.onChanged,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: labelText),
      value: value,
      onChanged: onChanged,
      items: items?.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}



// SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Nome Pianta*'),
//                     onSaved: (value) => selectedName = value,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Il campo nome pianta è obbligatorio';
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 16.0),
//                   DropdownFormField(
//                     labelText: 'Scegli pianta*',
//                     value: commonName,
//                     onChanged: (value) {
//                       setState(() {
//                         commonName = value;
//                       });
//                     },
//                     items: [
//                       'Lettuce',
//                       'Tomato',
//                       'Basil',
//                       'Hawthorn',
//                       'Marigold',
//                       'Hyacinth',
//                       'Orchid',
//                       'Rose',
//                     ],
//                   ),
//                   SizedBox(height: 16.0),
//                   DropdownFormField(
//                     labelText: 'Frequenza di irrigazione',
//                     value: wateringFrequency,
//                     onChanged: (value) {
//                       setState(() {
//                         wateringFrequency = value;
//                       });
//                     },
//                     items: [
//                       'Every 1 days',
//                       'Every 2 days',
//                       'Every 3 days',
//                       'Every 4 days',
//                     ],
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                         labelText: 'Giorni di crescita stimati'),
//                     keyboardType: TextInputType.number,
//                     onSaved: (value) => estimatedGrowingDays = value,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Il campo giorni di crescita stimati è obbligatorio';
//                       }
//                       if (int.tryParse(value) == null) {
//                         return 'Inserisci un valore numerico valido';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Descrizione'),
//                     onSaved: (value) => description = value,
//                   ),
//                   SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         _formKey.currentState!.save();
//                         final plant = Plant(
//                           selectedName: selectedName,
//                           commonName: commonName,
//                           wateringFrequency: wateringFrequency,
//                           description: description,
//                           estimated_growing_days:
//                               int.parse(estimatedGrowingDays!),
//                           planted_day: DateTime.now().toString(),
//                           propriety: 'null',
//                           image: 'null',
//                         );
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: Text('Risultato'),
//                               content: Text(plant.toString()),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text('OK'),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     },
//                     child: Text('Aggiungi Pianta'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )