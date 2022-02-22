import 'package:editor/src/editor/widgets/templates/template_editor/new_template_field_form.dart';
import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/project/bloc/project_state.dart';
import 'package:editor/src/templates/bloc/templates_bloc.dart';
import 'package:editor/src/widgets/icon_button.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

class TemplateEditor extends StatelessWidget {
  final String templateName;

  const TemplateEditor({
    Key? key,
    required this.templateName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TemplatesBloc, TemplatesState, ProjectTemplate>(
      key: Key('_template_editor$templateName'),
      selector: (state) {
        final templates = state.templates;
        return templates
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
    final fields = context.read<TemplatesBloc>().state.fields.where((t) => t.id == template.id);
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
                      templateId: template.id!,
                      fieldName: newField.name,
                      value: '',
                    );
                    break;
                  case NewTemplateFielType.number:
                    event = AddFieldTemplateEvent<double>(
                      templateId: template.id!,
                      fieldName: newField.name,
                      value: 0.0,
                    );
                    break;
                  case NewTemplateFielType.boolean:
                    event = AddFieldTemplateEvent<bool>(
                      templateId: template.id!,
                      fieldName: newField.name,
                      value: true,
                    );
                    break;
                }

                context.read<TemplatesBloc>().add(event);
              }
            },
          ),
          for (var field in fields)
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
                        context.read<TemplatesBloc>().add(
                              UpdateFieldTemplateEvent<String>(
                                templateId: template.id!,
                                fieldName: field.name,
                                value: newValue,
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
                        context.read<TemplatesBloc>().add(
                              UpdateFieldTemplateEvent<bool>(
                                templateId: template.id!,
                                fieldName: field.name,
                                value: newValue ?? false,
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
                        context.read<TemplatesBloc>().add(
                              UpdateFieldTemplateEvent<double>(
                                templateId: template.id!,
                                fieldName: field.name,
                                value: double.tryParse(newValue) ?? field.value,
                              ),
                            );
                      },
                    ),
                  ),

                IconButton(
                    data: Icons.remove_circle,
                    tooltip: 'Remove field',
                    onClick: () {
                      context.read<TemplatesBloc>().add(
                            RemoveFieldTemplateEvent(
                              templateId: template.id!,
                              fieldName: field.name,
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
