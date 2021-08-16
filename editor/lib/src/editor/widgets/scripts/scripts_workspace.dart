import 'package:editor/src/editor/bloc/editor_bloc.dart';
import 'package:editor/src/editor/bloc/editor_events.dart';
import 'package:editor/src/editor/bloc/editor_state.dart';
import 'package:editor/src/widgets/icon_button.dart';
import 'package:editor/src/widgets/side_bar.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'new_script_form.dart';
import 'script_side_item.dart';

class ScriptsWorkspace extends StatelessWidget {

  static const newScriptKey = Key('new_script_key');

  const ScriptsWorkspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        key: newScriptKey,
                        data: Icons.add,
                        tooltip: 'New script',
                        onClick: () async {
                          final script = await showDialog<NewScriptFormEntry>(
                            context: context,
                            builder: (context) {
                              return const NewScriptForm();
                            },
                          );

                          if (script != null) {
                            context
                                .read<EditorBloc>()
                                .add(NewScriptEvent(script.name, script.type));
                          }
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: SideBar(
                      children: state.scripts.map((e) {
                        return ScriptSideItem(
                            name: e.name,
                            type: e.type,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(color: Colors.black),
            ),
          ],
        );
      },
    );
  }
}
