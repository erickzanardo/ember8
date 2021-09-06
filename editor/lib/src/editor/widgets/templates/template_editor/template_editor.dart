import 'package:editor/src/editor/widgets/templates/template_editor/new_template_field_form.dart';
import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/project/bloc/project_events.dart';
import 'package:editor/src/project/bloc/project_state.dart';
import 'package:editor/src/project/models/project.dart';
import 'package:editor/src/widgets/icon_button.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemplateEditor extends StatelessWidget {
  final String templateName;

  const TemplateEditor({
    Key? key,
    required this.templateName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProjectBloc, ProjectState, ProjectTemplate>(
      key: Key('_sprite_editor$templateName'),
      selector: (state) {
        return state.project.templates
            .where((template) => template.name == templateName)
            .first;
      },
      builder: (context, template) {
        return _Editor(template: template);
      },
    );
  }
}

class _Editor extends StatelessWidget {
  final ProjectTemplate template;

  const _Editor({
    Key? key,
    required this.template,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            tooltip: 'New field',
            data: Icons.add_sharp,
            onClick: () async {
              final newField = await showDialog<NewTemplateFieldEntry>(
                context: context,
                builder: (_) => const NewTemplateFieldForm(),
              );

              if (newField != null) {
                late AddFieldTemplateEvent event;

                switch (newField.type) {
                  case NewTemplateFielType.string:
                    event = AddFieldTemplateEvent<String>(
                      template.name,
                      newField.name,
                      '',
                    );
                    break;
                  case NewTemplateFielType.number:
                    event = AddFieldTemplateEvent<double>(
                      template.name,
                      newField.name,
                      0.0,
                    );
                    break;
                  case NewTemplateFielType.boolean:
                    event = AddFieldTemplateEvent<bool>(
                      template.name,
                      newField.name,
                      true,
                    );
                    break;
                }

                context.read<ProjectBloc>().add(event);
              }
            },
          ),
          for (var field in template.fields)
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Center(child: Text(field.name)),
                ),
                if (field is ProjectTemplateField<String>)
                  Expanded(
                    child: TextFormField(
                      initialValue: field.value,
                      onChanged: (newValue) {
                        context.read<ProjectBloc>().add(
                              UpdateFieldTemplateEvent<String>(
                                template.name,
                                field.name,
                                newValue,
                              ),
                            );
                      },
                    ),
                  ),
                if (field is ProjectTemplateField<bool>)
                  Expanded(
                    child: Checkbox(
                      value: field.value,
                      onChanged: (newValue) {
                        context.read<ProjectBloc>().add(
                              UpdateFieldTemplateEvent<bool>(
                                template.name,
                                field.name,
                                newValue ?? false,
                              ),
                            );
                      },
                    ),
                  ),
                // TODO handle floating number here
                if (field is ProjectTemplateField<double>)
                  Expanded(
                    child: TextFormField(
                      initialValue: field.value.toInt().toString(),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (newValue) {
                        context.read<ProjectBloc>().add(
                              UpdateFieldTemplateEvent<double>(
                                template.name,
                                field.name,
                                double.tryParse(newValue) ?? field.value,
                              ),
                            );
                      },
                    ),
                  ),

                IconButton(
                    data: Icons.remove_circle,
                    tooltip: 'Remove field',
                    onClick: () {
                      context.read<ProjectBloc>().add(
                            RemoveFieldTemplateEvent(
                              template.name,
                              field.name,
                            ),
                          );
                    }),
              ],
            ),
        ],
      ),
    );
  }
}
