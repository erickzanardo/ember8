import 'package:editor/src/project/bloc/project_state.dart';
import 'package:flutter/material.dart';

class ScriptSideItem extends StatelessWidget {

  final ProjectScriptType type;
  final String name;

  const ScriptSideItem({
    Key? key,
    required this.type,
    required this.name,
  }) : super(key: key);

  IconData _mapTypeIcon() {
    switch(type) {
      case ProjectScriptType.dpad:
        return Icons.gamepad;
      case ProjectScriptType.action:
        return Icons.sports_mma;
      case ProjectScriptType.controller:
        return Icons.computer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
