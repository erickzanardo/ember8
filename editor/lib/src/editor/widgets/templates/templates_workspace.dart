import 'package:editor/src/editor/widgets/templates/template_editor/template_editor.dart';
import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/project/bloc/project_events.dart';
import 'package:editor/src/project/bloc/project_state.dart';
import 'package:editor/src/project/models/project.dart';
import 'package:editor/src/workspaces/bloc/workspace_bloc.dart';
import 'package:editor/src/workspaces/widgets/workspace.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'new_template_form.dart';

class TemplatesWorkspace extends StatelessWidget {
  static const newTemplateKey = Key('new_template_key');

  const TemplatesWorkspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        return Workspace<TemplatesWorkspaceBloc, ProjectTemplate>(
          addButtonKey: newTemplateKey,
          addButtonTooltip: 'New template',
          onAddButtonClick: () async {
            final template = await showDialog<NewTemplateFormEntry>(
              context: context,
              builder: (context) {
                return const NewTemplateForm();
              },
            );

            if (template != null) {
              context.read<ProjectBloc>().add(NewTemplateEvent(template.name));

              return template.name;
            }

            return null;
          },
          buildSideBarItem: (template) {
            return Text(template.name);
          },
          mapItemValue: (template) => template.name,
          items: state.project.templates,
          emptyMessage:
              'Nothing to show yet, select a template on the left side bar',
          buildCurrent: (current) => TemplateEditor(templateName: current),
        );
      },
    );
  }
}
