import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewSpriteFormEntry {
  final String name;
  final int width;
  final int height;

  NewSpriteFormEntry({
    required this.name,
    required this.width,
    required this.height,
  });
}

class NewSpriteForm extends StatefulWidget {
  const NewSpriteForm({Key? key}) : super(key: key);

  @override
  State<NewSpriteForm> createState() => _NewSpriteFormState();
}

class _NewSpriteFormState extends State<NewSpriteForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 300,
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Sprite name',
                    ),
                    autofocus: true,
                    controller: _nameController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'This field is required';
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Sprite width',
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    autofocus: true,
                    controller: _widthController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'This field is required';
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Sprite height',
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    autofocus: true,
                    controller: _heightController,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        return null;
                      }
                      return 'This field is required';
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final script  = NewSpriteFormEntry(
                            name: _nameController.text,
                            width: int.parse(_widthController.text),
                            height: int.parse(_heightController.text),
                        );
                        Navigator.of(context).pop(script);
                      }
                    },
                    child: const Text('Create'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
