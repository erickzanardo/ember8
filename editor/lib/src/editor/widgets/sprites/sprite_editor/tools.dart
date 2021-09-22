import 'package:editor/src/editor/widgets/sprites/sprite_editor/sprite_editor.dart';
import 'package:editor/src/widgets/icon_button.dart';
import 'package:flutter/material.dart' hide IconButton;

class Tools extends StatelessWidget {
  final void Function(SpriteEditorTool) onSelectTool;
  final SpriteEditorTool tool;

  const Tools({
    Key? key,
    required this.onSelectTool,
    required this.tool,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          IconButton(
            data: Icons.brush,
            tooltip: 'Brush',
            primary: tool == SpriteEditorTool.brush,
            onClick: () {
              onSelectTool(SpriteEditorTool.brush);
            },
          ),
          IconButton(
            data: Icons.crop_7_5_sharp,
            tooltip: 'Eraser',
            primary: tool == SpriteEditorTool.eraser,
            onClick: () {
              onSelectTool(SpriteEditorTool.eraser);
            },
          ),
        ],
      ),
    );
  }
}
