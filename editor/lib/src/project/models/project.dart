import 'package:equatable/equatable.dart';

part './project_script.dart';
part './project_sprite.dart';
part './project_template.dart';
part './project_stage.dart';

class Project extends Equatable {
  final List<ProjectScript> scripts;
  final List<ProjectSprite> sprites;
  final List<ProjectTemplate> templates;
  final List<ProjectStage> stages;

  const Project({
    this.scripts = const [],
    this.sprites = const [],
    this.templates = const [],
    this.stages = const [],
  });

  @override
  List<Object?> get props => [scripts, sprites, templates, stages];

  Project copyWith({
    List<ProjectScript>? scripts,
    List<ProjectSprite>? sprites,
    List<ProjectTemplate>? templates,
    List<ProjectStage>? stages,
  }) {
    return Project(
      scripts: scripts ?? this.scripts,
      sprites: sprites ?? this.sprites,
      templates: templates ?? this.templates,
      stages: stages ?? this.stages,
    );
  }
}
