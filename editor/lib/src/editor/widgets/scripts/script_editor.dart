import 'package:editor/src/editor/widgets/scripts/script_code_field.dart';
import 'package:editor/src/widgets/tab.dart';
import 'package:editor/src/workspaces/bloc/workspace_bloc.dart';
import 'package:editor/src/workspaces/bloc/workspace_events.dart';
import 'package:editor/src/workspaces/bloc/workspace_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide Tab;
import 'package:flutter_bloc/flutter_bloc.dart';

class _ScriptEditorSelector extends Equatable {
  final String selected;
  final List<String> open;

  const _ScriptEditorSelector(this.selected, this.open);

  @override
  List<Object?> get props => [selected, open];
}

class ScriptEditor extends StatelessWidget {
  const ScriptEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScriptsWorkspaceBloc, WorkspaceState,
        _ScriptEditorSelector>(
      selector: (state) => _ScriptEditorSelector(
        state.currentEditor,
        state.openEditors,
      ),
      builder: (context, selection) {
        if (selection.open.isEmpty) {
          return const Center(
              child: Text(
                  'Nothing open yet, select a script on the left side bar'));
        }
        return Column(
          children: [
            Row(
              children: selection.open.map((script) {
                return SizedBox(
                  width: 200,
                  child: Tab(
                    label: script,
                    selected: script == selection.selected,
                    onClick: () {
                      context
                          .read<ScriptsWorkspaceBloc>()
                          .add(SelectEditorEvent(script));
                    },
                    onClose: () {
                      context
                          .read<ScriptsWorkspaceBloc>()
                          .add(CloseEditorEvent(script));
                    },
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: ScriptCodeField(
                scriptName: selection.selected,
              ),
            ),
          ],
        );
      },
    );
  }
}
