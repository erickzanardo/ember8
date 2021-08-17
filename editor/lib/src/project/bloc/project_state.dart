import 'package:equatable/equatable.dart';

enum ProjectScriptType {
  controller,
  dpad,
  action,
}

class ProjectScript extends Equatable {
  final ProjectScriptType type;
  final String name;
  final String body;

  const ProjectScript({
    required this.type,
    required this.name,
    required this.body,
  });

  @override
  List<Object?> get props => [type, name, body];

  ProjectScript copyWithNewBody(String body) {
    return ProjectScript(
        type: type,
        name: name,
        body: body,
    );
  }
}


class ProjectState extends Equatable {
  final List<ProjectScript> scripts;

  const ProjectState({
    this.scripts = const [],
  });

  @override
  List<Object?> get props => [scripts];

  ProjectState copyWith({
    List<ProjectScript>? scripts,
  }) {
    return ProjectState(
        scripts: scripts ?? this.scripts,
    );
  }
}
