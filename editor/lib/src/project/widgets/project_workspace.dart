import 'package:editor/src/editor/editor.dart';
import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'empty_project_view.dart';

class ProjectWorkspace extends StatelessWidget {
  const ProjectWorkspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProjectBloc>().state;
    final currentProject = state.project;

    if (currentProject != null) {
      return const Editor();
    } else {
      return const EmptyProjectView();
    }
  }
}
