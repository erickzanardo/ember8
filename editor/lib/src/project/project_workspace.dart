import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../editor/editor.dart';

class ProjectWorkspace extends StatelessWidget {
  const ProjectWorkspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<ProjectBloc>(
          create: (_) => ProjectBloc(),
          child: const Editor(),
        ),
      ),
    );
  }
}
