import 'package:editor/src/widgets/clickable.dart';
import 'package:engine/engine.dart';
import 'package:flutter/material.dart';

class ColorPalette extends StatefulWidget {
  final void Function(int) onSelectColor;
  final EmberPalette palette;

  const ColorPalette({
    Key? key,
    required this.onSelectColor,
    required this.palette,
  }) : super(key: key);

  @override
  State<ColorPalette> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  Color? _color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: widget.palette.colors.map(
          (color) {
            return Clickable(
              onClick: () {
                setState(() {
                  _color = color;
                });
                widget.onSelectColor(widget.palette.colors.indexOf(color));
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(
                    width: 3,
                    color: color == _color
                        ? Colors.black
                        : Theme.of(context).dividerColor,
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
