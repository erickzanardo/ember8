part of 'project.dart';

/// {@template project_sprite_model}
///
/// Model of sprite of a project
///
/// {@endtemplate}
class ProjectSprite extends Equatable {
  /// {@macro project_sprite_model}
  const ProjectSprite({
    this.id,
    required this.projectId,
    required this.name,
    required this.pixels,
  });

  /// Id of this sprite
  final String? id;

  /// Id of the project that this sprite belongs to
  final String projectId;

  /// Name of the sprite
  final String name;

  /// Data of the sprite
  final List<List<int?>> pixels;

  @override
  List<Object?> get props => [name, pixels];

  /// Copies this instance with the given values
  ProjectSprite copyWith({
    List<List<int?>>? pixels,
  }) {
    return ProjectSprite(
      id: id,
      projectId: projectId,
      name: name,
      pixels: pixels ?? this.pixels,
    );
  }
}
