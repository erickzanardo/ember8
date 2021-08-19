import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/workspaces/bloc/workspace_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/editor_bloc.dart';
import 'widgets/editor_scaffold.dart';

class Editor extends StatelessWidget {

  const Editor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: MultiBlocProvider(
                providers: [
                  BlocProvider<EditorBloc>(
                      create: (_) => EditorBloc(),
                  ),
                  BlocProvider<ScriptsWorkspaceBloc>(
                      create: (_) => ScriptsWorkspaceBloc(),
                  ),
                  BlocProvider<SpritesWorkspaceBloc>(
                      create: (_) => SpritesWorkspaceBloc(),
                  ),
                  BlocProvider<ProjectBloc>(
                      create: (_) => ProjectBloc(),
                  ),
                ],
                child: const EditorScaffold(),
            ),
        ),
    );
  }
}
