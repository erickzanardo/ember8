import 'package:flutter/material.dart';

class NewTemplateFormEntry {
  final String name;

  NewTemplateFormEntry({
    required this.name,
  });
}

class NewTemplateForm extends StatefulWidget {
  const NewTemplateForm({Key? key}) : super(key: key);

  @override
  State<NewTemplateForm> createState() => _NewTemplateFormState();
}

class _NewTemplateFormState extends State<NewTemplateForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 150,
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
                      labelText: 'Template name',
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
                        final template = NewTemplateFormEntry(
                          name: _nameController.text,
                        );
                        Navigator.of(context).pop(template);
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
