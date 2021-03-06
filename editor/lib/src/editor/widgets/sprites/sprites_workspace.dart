import 'package:editor/src/editor/widgets/sprites/new_sprite_form.dart';
import 'package:editor/src/editor/widgets/sprites/sprite_editor/sprite_editor.dart';
import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/project/bloc/project_state.dart';
import 'package:editor/src/sprites/bloc/sprites_bloc.dart';
import 'package:editor/src/workspaces/bloc/workspace_bloc.dart';
import 'package:editor/src/workspaces/widgets/workspace.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

class SpritesWorkspace extends StatelessWidget {
  static const newSpriteKey = Key('new_sprite_key');

  const SpritesWorkspace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpritesBloc, SpritesState>(
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
              final projectId = context.read<ProjectBloc>().state.projectId;
              context.read<SpritesBloc>().add(
                    NewSpriteEvent(
                      projectId: projectId,
                      name: sprite.name,
                      width: sprite.width,
                      height: sprite.height,
                    ),
                  );

              return sprite.name;
            }

            return null;
          },
          buildSideBarItem: (sprite) {
            // TODO we could show the small image here
            return Text(sprite.name);
          },
          mapItemValue: (sprite) => sprite.name,
          items: state.sprites,
          emptyMessage:
              'Nothing to show yet, select a sprite on the left side bar',
          buildCurrent: (current) => SpriteEditor(spriteName: current),
        );
      },
    );
  }
}
