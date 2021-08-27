import 'package:flutter/material.dart';

enum NewTemplateFielType {
  string,
  boolean,
  number,
}

class NewTemplateFieldEntry {
  final String name;
  final NewTemplateFielType type;

  NewTemplateFieldEntry(this.name, this.type);
}

class NewTemplateFieldForm extends StatefulWidget {
  const NewTemplateFieldForm({Key? key}) : super(key: key);

  @override
  State<NewTemplateFieldForm> createState() => _NewTemplateFieldFormState();
}

class _NewTemplateFieldFormState extends State<NewTemplateFieldForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  var _type = NewTemplateFielType.string;

  String _mapTypeLabel(NewTemplateFielType type) {
    switch (type) {
      case NewTemplateFielType.string:
        return 'String';
      case NewTemplateFielType.boolean:
        return 'Boolean';
      case NewTemplateFielType.number:
        return 'Number (double)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 220,
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
                      labelText: 'Field name',
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
                  DropdownButtonFormField<NewTemplateFielType>(
                    value: _type,
                    decoration: const InputDecoration(
                      labelText: 'Field type',
                    ),
                    onChanged: (type) {
                      setState(() {
                        if (type != null) {
                          _type = type;
                        }
                      });
                    },
                    items: NewTemplateFielType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(
                          _mapTypeLabel(type),
                        ),
                      );
                    }).toList(),
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
                        Navigator.of(context).pop(
                          NewTemplateFieldEntry(
                            _nameController.text,
                            _type,
                          ),
                        );
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
