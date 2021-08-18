import 'package:editor/src/editor/widgets/scripts/script_editor.dart';
import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/project/bloc/project_events.dart';
import 'package:editor/src/project/bloc/project_state.dart';
import 'package:editor/src/widgets/icon_button.dart';
import 'package:editor/src/widgets/side_bar.dart';
import 'package:editor/src/workspaces/bloc/workspace_bloc.dart';
import 'package:editor/src/workspaces/bloc/workspace_events.dart';
import 'package:editor/src/workspaces/widgets/workspace.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'new_script_form.dart';
import 'script_side_item.dart';

class ScriptsWorkspace extends StatelessWidget {
  static const newScriptKey = Key('new_script_key');

  const ScriptsWorkspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        return Workspace<ScriptsWorkspaceBloc, ProjectScript>(
            addButtonKey: newScriptKey,
            addButtonTooltip: 'New script',
            onAddButtonClick: () async {
              final script = await showDialog<NewScriptFormEntry>(
                  context: context,
                  builder: (context) {
                    return const NewScriptForm();
                  },
              );

              if (script != null) {
                context
                    .read<ProjectBloc>()
                    .add(NewScriptEvent(script.name, script.type));
              }
            },
            buildSideBarItem: (script) {
              return ScriptSideItem(
                  name: script.name,
                  type: script.type,
              );
            },
            mapItemValue: (script) => script.name,
            items: state.scripts,
            editor: const ScriptEditor(),
        );
      },
    );
  }
}
