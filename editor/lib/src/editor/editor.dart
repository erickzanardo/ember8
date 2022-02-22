import 'package:editor/src/scripts/bloc/scripts_bloc.dart';
import 'package:editor/src/sprites/bloc/sprites_bloc.dart';
import 'package:editor/src/stages/bloc/stages_bloc.dart';
import 'package:editor/src/templates/bloc/templates_bloc.dart';
import 'package:editor/src/workspaces/bloc/workspace_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/editor_bloc.dart';
import 'widgets/editor_scaffold.dart';

class Editor extends StatelessWidget {
  const Editor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
        BlocProvider<TemplatesWorkspaceBloc>(
          create: (_) => TemplatesWorkspaceBloc(),
        ),
        BlocProvider<StagesWorkspaceBloc>(
          create: (_) => StagesWorkspaceBloc(),
        ),
        BlocProvider<ScriptsBloc>(
          create: (_) => ScriptsBloc(),
        ),
        BlocProvider<SpritesBloc>(
          create: (_) => SpritesBloc(),
        ),
        BlocProvider<TemplatesBloc>(
          create: (_) => TemplatesBloc(),
        ),
        BlocProvider<StagesBloc>(
          create: (_) => StagesBloc(),
        ),
      ],
      child: const EditorScaffold(),
    );
  }
}
