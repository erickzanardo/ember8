import 'package:equatable/equatable.dart';

import 'project_state.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();
}

class NewScriptEvent extends ProjectEvent {
  final String name;
  final ProjectScriptType type;

  const NewScriptEvent(this.name, this.type);

  @override
  List<Object?> get props => [name, type];
}

class UpdateScriptEvent extends ProjectEvent {
  final String name;
  final String code;

  const UpdateScriptEvent(this.name, this.code);

  @override
  List<Object?> get props => [name, code];
}

