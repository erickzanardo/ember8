import 'package:editor/src/editor/widgets/stages/stages_editor/stage_editor.dart';
import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/stages/bloc/stages_bloc.dart';
import 'package:editor/src/workspaces/bloc/workspace_bloc.dart';
import 'package:editor/src/workspaces/widgets/workspace.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

import 'new_stage_form.dart';

class StagesWorkspace extends StatelessWidget {
  static const newStageKey = Key('new_stage_key');

  const StagesWorkspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StagesBloc, StagesState>(
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
              final projectId = context.read<ProjectBloc>().state.projectId;

              context.read<StagesBloc>().add(NewStageEvent(projectId: projectId, name: stage.name,),);

              return stage.name;
            }

            return null;
          },
          buildSideBarItem: (stage) {
            return Text(stage.name);
          },
          mapItemValue: (stage) => stage.name,
          items: state.stages,
          emptyMessage:
              'Nothing to show yet, select a stage on the left side bar',
          buildCurrent: (current) => StageEditor(stageName: current),
        );
      },
    );
  }
}
