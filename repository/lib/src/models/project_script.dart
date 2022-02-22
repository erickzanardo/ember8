part of 'project.dart';

/// Enum with the possible types of an event
enum ProjectScriptType {
  controller,
  dpad,
  action,
}

/// {@template project_script_model}
///
/// Model representing a script from a [Project]
///
/// {@endtemplate}
class ProjectScript extends Equatable {

  /// {@macro project_script_model}
  const ProjectScript({
    this.id,
    required this.projectId,
    required this.type,
    required this.name,
    required this.body,
  });

  /// Id of the script
  final String? id;

  /// Id of the project that this script belongs to
  final String projectId;

  /// Type of the script
  final ProjectScriptType type;
  /// Name of the script
  final String name;
  /// Body of the script
  final String body;


  @override
  List<Object?> get props => [id, projectId, type, name, body];

  /// Copies this instance with the given values
  ProjectScript copyWith({
    String? body,
  }) {
    return ProjectScript(
      id: id,
      projectId: projectId,
      type: type,
      name: name,
      body: body ?? this.body,
    );
  }
}
