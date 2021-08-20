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

  ProjectSprite copyWithNewPixels(List<List<int?>> pixels) {
    return ProjectSprite(name: name, pixels: pixels);
  }
}

class ProjectTemplateField<T> extends Equatable {
  final String name;
  final T value;

  const ProjectTemplateField(this.name, this.value);

  @override
  List<Object?> get props => [name, value];
}

class ProjectTemplate extends Equatable {
  final String name;
  final List<ProjectTemplateField> fields;

  const ProjectTemplate(this.name, this.fields);

  @override
  List<Object?> get props => [name, fields];
}

class ProjectState extends Equatable {
  final List<ProjectScript> scripts;
  final List<ProjectSprite> sprites;
  final List<ProjectTemplate> templates;

  const ProjectState({
    this.scripts = const [],
    this.sprites = const [],
    this.templates = const [],
  });

  @override
  List<Object?> get props => [scripts, sprites, templates];

  ProjectState copyWith({
    List<ProjectScript>? scripts,
    List<ProjectSprite>? sprites,
    List<ProjectTemplate>? templates,
  }) {
    return ProjectState(
        scripts: scripts ?? this.scripts,
        sprites: sprites ?? this.sprites,
        templates: templates ?? this.templates,
    );
  }
}
