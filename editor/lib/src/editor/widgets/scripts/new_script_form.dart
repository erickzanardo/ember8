import 'package:editor/src/editor/bloc/editor_state.dart';
import 'package:flutter/material.dart';

class NewScriptFormEntry {
  final String name;
  final EditorScriptType type;

  NewScriptFormEntry(this.name, this.type);
}

class NewScriptForm extends StatefulWidget {
  const NewScriptForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewScriptFormState();
  }
}

class _NewScriptFormState extends State<NewScriptForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  EditorScriptType _type = EditorScriptType.controller;

  String _mapTypeLabel(EditorScriptType type) {
    switch (type) {
      case EditorScriptType.dpad:
        return 'Directional Pad';
      case EditorScriptType.action:
        return 'Action Button';
      case EditorScriptType.controller:
        return 'Controller';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 250,
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
                      labelText: 'Script name',
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
                  DropdownButtonFormField<EditorScriptType>(
                    value: _type,
                    decoration: const InputDecoration(
                      labelText: 'Script type',
                    ),
                    onChanged: (type) {
                      setState(() {
                        if (type != null) {
                          _type = type;
                        }
                      });
                    },
                    items: EditorScriptType.values.map((type) {
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
                        final script  = NewScriptFormEntry(
                            _nameController.text,
                            _type,
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
