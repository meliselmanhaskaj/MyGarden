import 'package:address_24/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreatePlantForm extends StatefulWidget {
  const CreatePlantForm({super.key});

  @override
  State<CreatePlantForm> createState() => _CreatePlantFormState();
}

class _CreatePlantFormState extends State<CreatePlantForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Card(child:
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Cercare pianta da piantare'))),
          ),
          TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'How do you what to name the Plant?',
                labelText: "Plant's name*",
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value != null && value.isEmpty) ? 'ciao' : null;
              },
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  print('Pianta trovata');
                }
              },
              child: const Text('Create plant'),
            ),
          )
        ],
      ),
    );
  }
}