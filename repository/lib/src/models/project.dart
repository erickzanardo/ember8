import 'package:equatable/equatable.dart';

part './project_script.dart';
part './project_sprite.dart';
part './project_template.dart';
part './project_stage.dart';

/// {@template project_model}
///
/// Model for a project
///
/// {@endtemplate}
class Project extends Equatable {

  /// {@macro project_model}
  const Project({
    this.id,
    required this.userId,
    required this.name,
  });

  /// Id of this project
  final String? id;

  /// Id of the user owner of this project
  final String userId;

  /// Project name
  final String name;

  @override
  List<Object?> get props => [id, userId, name];

  /// Copy this instance with the given values
  Project copyWith({
    String? id,
    String? userId,
    String? name,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
    );
  }
}
