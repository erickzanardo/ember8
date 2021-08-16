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
            body: BlocProvider(
                create: (_) => EditorBloc(),
                child: const EditorScaffold(),
            ),
        ),
    );
  }
}
