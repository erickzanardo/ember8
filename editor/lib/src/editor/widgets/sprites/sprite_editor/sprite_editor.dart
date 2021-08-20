import 'package:editor/src/editor/widgets/sprites/sprite_editor/color_palette.dart';
import 'package:editor/src/editor/widgets/sprites/sprite_editor/sprite_editor_cell.dart';
import 'package:editor/src/editor/widgets/sprites/sprite_editor/tools.dart';
import 'package:editor/src/project/bloc/project_bloc.dart';
import 'package:editor/src/project/bloc/project_events.dart';
import 'package:editor/src/project/bloc/project_state.dart';
import 'package:engine/engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SpriteEditorTool {
  brush,
  eraser,
}

class SpriteEditor extends StatelessWidget {
  final String spriteName;

  const SpriteEditor({
    Key? key,
    required this.spriteName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProjectBloc, ProjectState, ProjectSprite>(
      key: Key('_sprite_editor$spriteName'),
      selector: (state) {
        return state.sprites.where((sprite) => sprite.name == spriteName).first;
      },
      builder: (context, sprite) {
        return _Editor(sprite: sprite);
      },
    );
  }
}

class _Editor extends StatefulWidget {
  final ProjectSprite sprite;

  const _Editor({
    Key? key,
    required this.sprite,
  }) : super(key: key);

  @override
  State<_Editor> createState() => _EditorState();
}

class _EditorState extends State<_Editor> {
  int _pixelSize = 50;

  // TODO this will come from a project config
  final EmberPalette _palette = const EmberPalette.color();
  int? _color;

  SpriteEditorTool _currentTool = SpriteEditorTool.brush;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).dividerColor,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: (widget.sprite.pixels[0].length * _pixelSize).toDouble(),
              height: (widget.sprite.pixels.length * _pixelSize).toDouble(),
              child: Column(
                children: [
                  for (var y = 0; y < widget.sprite.pixels.length; y++)
                    Row(
                      children: [
                        for (var x = 0; x < widget.sprite.pixels[y].length; x++)
                          GestureDetector(
                            onTap: () {
                              context.read<ProjectBloc>().add(
                                    PaintSpritePixelEvent(
                                      spriteName: widget.sprite.name,
                                      x: x,
                                      y: y,
                                      color: _currentTool == SpriteEditorTool.brush
                                        ? _color
                                        : null,
                                    ),
                                  );
                            },
                            child: SpriteEditorCell(
                              palette: _palette,
                              pixelSize: _pixelSize,
                              color: widget.sprite.pixels[y][x],
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: ColorPalette(
              palette: _palette,
              onSelectColor: (color) {
                setState(() {
                  _color = color;
                });
              },
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Tools(
              tool: _currentTool,
              onSelectTool: (tool) {
                setState(() {
                  _currentTool = tool;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
