import 'package:equatable/equatable.dart';

import 'editor_state.dart';

abstract class EditorEvent extends Equatable {
  const EditorEvent();
}

class SelectTabEvent extends EditorEvent {
  final EditorTab newTab;

  const SelectTabEvent(this.newTab);

  @override
  List<Object?> get props => [newTab];
}

class NewScriptEvent extends EditorEvent {
  final String name;
  final EditorScriptType type;

  const NewScriptEvent(this.name, this.type);

  @override
  List<Object?> get props => [name, type];
}
