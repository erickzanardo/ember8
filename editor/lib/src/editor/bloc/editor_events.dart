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

class OpenScriptEvent extends EditorEvent {
  final String scriptName;

  const OpenScriptEvent(this.scriptName);

  @override
  List<Object?> get props => [scriptName];
}

class CloseScriptEvent extends EditorEvent {
  final String scriptName;

  const CloseScriptEvent(this.scriptName);

  @override
  List<Object?> get props => [scriptName];
}

class SelectScriptEvent extends EditorEvent {
  final String scriptName;

  const SelectScriptEvent(this.scriptName);

  @override
  List<Object?> get props => [scriptName];
}
