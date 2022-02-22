part of 'scripts_bloc.dart';

abstract class ScriptsEvent extends Equatable {
  const ScriptsEvent();
}

class NewScriptEvent extends ScriptsEvent {
  final String projectId;
  final String name;
  final ProjectScriptType type;

  const NewScriptEvent({
    required this.projectId,
    required this.name,
    required this.type,
  });

  @override
  List<Object?> get props => [projectId, name, type];
}

class UpdateScriptEvent extends ScriptsEvent {
  final String name;
  final String code;

  const UpdateScriptEvent(this.name, this.code);

  @override
  List<Object?> get props => [name, code];
}
