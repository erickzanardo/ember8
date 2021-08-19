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

class ProjectSprite extends Equatable {
  final String name;
  final List<List<int?>> pixels;

  const ProjectSprite({
    required this.name,
    required this.pixels,
  });

  @override
  List<Object?> get props => [name, pixels];
}

class ProjectState extends Equatable {
  final List<ProjectScript> scripts;
  final List<ProjectSprite> sprites;

  const ProjectState({
    this.scripts = const [],
    this.sprites = const [],
  });

  @override
  List<Object?> get props => [scripts, sprites];

  ProjectState copyWith({
    List<ProjectScript>? scripts,
    List<ProjectSprite>? sprites,
  }) {
    return ProjectState(
        scripts: scripts ?? this.scripts,
        sprites: sprites ?? this.sprites,
    );
  }
}
