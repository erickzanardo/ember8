import 'package:editor/src/editor/widgets/scripts/scripts_workspace.dart';
import 'package:flutter/material.dart' hide Tab;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/editor_bloc.dart';
import '../bloc/editor_state.dart';
import '../bloc/editor_events.dart';

import '../../widgets/tab.dart';

class EditorScaffold extends StatelessWidget {
  const EditorScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) {
        return Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Tab(
                          label: 'Scripts',
                          selected: state.currentTab == EditorTab.scripts,
                          onClick: () {
                            context.read<EditorBloc>().add(const SelectTabEvent(EditorTab.scripts));
                          },
                      ),
                    ),
                    Expanded(
                      child: Tab(
                          label: 'Sprites',
                          selected: state.currentTab == EditorTab.sprites,
                          onClick: () {
                            context.read<EditorBloc>().add(const SelectTabEvent(EditorTab.sprites));
                          },
                      ),
                    ),
                    Expanded(
                      child: Tab(
                          label: 'Stages',
                          selected: state.currentTab == EditorTab.stages,
                          onClick: () {
                            context.read<EditorBloc>().add(const SelectTabEvent(EditorTab.stages));
                          },
                      ),
                    ),
                  ],
              ),
              if (state.currentTab == EditorTab.scripts)
                const Expanded(child: ScriptsWorkspace()),
              if (state.currentTab == EditorTab.sprites)
                Expanded(child: Text(state.currentTab.toString())),
              if (state.currentTab == EditorTab.stages)
                Expanded(child: Text(state.currentTab.toString())),
            ],
        );
      }
    );
  }
}
