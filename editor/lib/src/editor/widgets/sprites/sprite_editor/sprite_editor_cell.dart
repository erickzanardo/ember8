import 'package:engine/engine.dart';
import 'package:flutter/material.dart';

class SpriteEditorCell extends StatelessWidget {
  final int pixelSize;
  final int? color;
  final EmberPalette palette;

  const SpriteEditorCell({
    Key? key,
    required this.pixelSize,
    required this.palette,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: pixelSize.toDouble(),
        height: pixelSize.toDouble(),
        decoration: BoxDecoration(
            color: color != null
            ? palette.colors[color!]
            : Colors.transparent,
            border: Border.all(
                width: 1,
                color: Colors.black,
            ), // Depends on the grid
        ),
    );
  }
}
