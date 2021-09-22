import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/project/widgets/project_workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Project extends StatelessWidget {
  const Project({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<ProjectBloc>(
          create: (_) => ProjectBloc(),
          child: const ProjectWorkspace(),
        ),
      ),
    );
  }
}
