import 'package:editor/src/editor/widgets/stages/stages_editor/stage_editor.dart';
import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/project/bloc/project_events.dart';
import 'package:editor/src/project/bloc/project_state.dart';
import 'package:editor/src/workspaces/bloc/workspace_bloc.dart';
import 'package:editor/src/workspaces/widgets/workspace.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'new_stage_form.dart';

class StagesWorkspace extends StatelessWidget {
  static const newStageKey = Key('new_stage_key');

  const StagesWorkspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        return Workspace<StagesWorkspaceBloc, ProjectStage>(
          addButtonKey: newStageKey,
          addButtonTooltip: 'New stage',
          onAddButtonClick: () async {
            final stage = await showDialog<NewStageFormEntry>(
              context: context,
              builder: (context) {
                return const NewStageForm();
              },
            );

            if (stage != null) {
              context.read<ProjectBloc>().add(NewStageEvent(stage.name));

              return stage.name;
            }

            return null;
          },
          buildSideBarItem: (stage) {
            return Text(stage.name);
          },
          mapItemValue: (stage) => stage.name,
          items: state.stages,
          emptyMessage: 'Nothing to show yet, select a stage on the left side bar',
          buildCurrent: (current) => StageEditor(stageName: current),
        );
      },
    );
  }
}

