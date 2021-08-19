import 'package:editor/src/widgets/tab.dart';
import 'package:editor/src/workspaces/bloc/workspace_bloc.dart';
import 'package:editor/src/workspaces/bloc/workspace_events.dart';
import 'package:editor/src/workspaces/bloc/workspace_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide Tab;
import 'package:flutter_bloc/flutter_bloc.dart';

class _WorkspaceEditorSelector extends Equatable {
  final String selected;
  final List<String> open;

  const _WorkspaceEditorSelector(this.selected, this.open);

  @override
  List<Object?> get props => [selected, open];
}

class WorkspaceEditor<T extends WorkspaceBloc> extends StatelessWidget {
  final String emptyMessage;
  final Widget Function(String) buildCurrent;

  const WorkspaceEditor({
    Key? key,
    required this.emptyMessage,
    required this.buildCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<T, WorkspaceState, _WorkspaceEditorSelector>(
      selector: (state) => _WorkspaceEditorSelector(
        state.currentEditor,
        state.openEditors,
      ),
      builder: (context, selection) {
        if (selection.open.isEmpty) {
          return Center(
            child: Text(emptyMessage),
          );
        }
        return Column(
          children: [
            Row(
              children: selection.open.map((editor) {
                return SizedBox(
                  width: 200,
                  child: Tab(
                    label: editor,
                    selected: editor == selection.selected,
                    onClick: () {
                      context.read<T>().add(SelectEditorEvent(editor));
                    },
                    onClose: () {
                      context.read<T>().add(CloseEditorEvent(editor));
                    },
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: buildCurrent(selection.selected),
            ),
          ],
        );
      },
    );
  }
}
