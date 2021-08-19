import 'package:editor/src/editor/widgets/sprites/new_sprite_form.dart';
import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/project/bloc/project_events.dart';
import 'package:editor/src/project/bloc/project_state.dart';
import 'package:editor/src/workspaces/bloc/workspace_bloc.dart';
import 'package:editor/src/workspaces/widgets/workspace.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:flutter_bloc/flutter_bloc.dart';

class SpritesWorkspace extends StatelessWidget {
  static const newSpriteKey = Key('new_sprite_key');

  const SpritesWorkspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        return Workspace<SpritesWorkspaceBloc, ProjectSprite>(
          addButtonKey: newSpriteKey,
          addButtonTooltip: 'New sprite',
          onAddButtonClick: () async {
            final sprite = await showDialog<NewSpriteFormEntry>(
              context: context,
              builder: (context) {
                return const NewSpriteForm();
              },
            );

            if (sprite != null) {
              context.read<ProjectBloc>().add(
                    NewSpriteEvent(
                      name: sprite.name,
                      width: sprite.width,
                      height: sprite.height,
                    ),
                  );
            }
          },
          buildSideBarItem: (sprite) {
            // TODO we could show the small image here
            return Text(sprite.name);
          },
          mapItemValue: (sprite) => sprite.name,
          items: state.sprites,
          emptyMessage: 'Nothing to show yet, select a sprite on the left side bar',
          buildCurrent: (_) => Container(color: Colors.blue),
        );
      },
    );
  }
}
