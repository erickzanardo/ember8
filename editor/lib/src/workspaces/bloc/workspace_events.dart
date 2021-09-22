import 'package:equatable/equatable.dart';

abstract class WorkspaceEvent extends Equatable {
  const WorkspaceEvent();
}

class OpenEditorEvent extends WorkspaceEvent {
  final String name;

  const OpenEditorEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class CloseEditorEvent extends WorkspaceEvent {
  final String name;

  const CloseEditorEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class SelectEditorEvent extends WorkspaceEvent {
  final String name;

  const SelectEditorEvent(this.name);

  @override
  List<Object?> get props => [name];
}
