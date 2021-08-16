import 'package:editor/src/editor/bloc/editor_state.dart';
import 'package:flutter/material.dart';

class ScriptSideItem extends StatelessWidget {

  final EditorScriptType type;
  final String name;

  const ScriptSideItem({
    Key? key,
    required this.type,
    required this.name,
  }) : super(key: key);

  IconData _mapTypeIcon() {
    switch(type) {
      case EditorScriptType.dpad:
        return Icons.gamepad;
      case EditorScriptType.action:
        return Icons.sports_mma;
      case EditorScriptType.controller:
        return Icons.computer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(_mapTypeIcon()),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(name),
              ),
            ),
          ],
      ),
    );
  }
}
