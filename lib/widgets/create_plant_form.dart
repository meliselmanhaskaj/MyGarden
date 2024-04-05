import 'package:address_24/main.dart';
import 'package:flutter/material.dart';

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
          Text('Cercare pianta da piantare'),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty){
                return "It doesn't exist a plant without a name";
              }
              
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
