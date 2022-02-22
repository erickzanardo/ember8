import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/project/bloc/project_state.dart';
import 'package:editor/src/stages/bloc/stages_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

class _StageEditorSelection extends Equatable {
  final ProjectStage stage;
  final List<ProjectTemplate> templates;

  const _StageEditorSelection(this.stage, this.templates);

  @override
  List<Object?> get props => [stage, templates];
}

class StageEditor extends StatelessWidget {
  final String stageName;

  const StageEditor({
    Key? key,
    required this.stageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<StagesBloc, StagesState, _StageEditorSelection>(
      key: Key('_stage_editor$stageName'),
      selector: (state) {
        final stages = state.stages;
        final stage = stages.where((stage) => stage.name == stageName).first;

        return _StageEditorSelection(stage, /*state.project?.templates ?? []*/ const []); // TODO figure this out
      },
      builder: (context, selection) {
        return _Editor(data: selection);
      },
    );
  }
}

class _Editor extends StatelessWidget {
  final _StageEditorSelection data;

  const _Editor({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Container(color: Colors.red),
        ),
        Expanded(
          flex: 2,
          child: Container(color: Colors.blue),
        ),
      ],
    );
  }
}
