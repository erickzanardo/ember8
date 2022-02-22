part of 'project.dart';

/// {@template project_stage_obect_model}
///
/// Model of a template object
///
/// {@endtemplate}
class ProjectStageObject extends Equatable {

  /// {@macro project_stage_obect_model}
  const ProjectStageObject({
    this.id,
    required this.stageId,
    required this.name,
    required this.templateName,
    required this.x,
    required this.y,
  });

  /// Id of this object
  final String? id;
  /// Id of the stage this object belongs to
  final String stageId;
  /// Name of this object
  final String name;
  /// Name of the templateName
  final String templateName;
  /// X coordinate of this object
  final double x;
  /// Y coordinate of this object
  final double y;


  @override
  List<Object?> get props => [id, stageId, name, templateName, x, y];
}

/// {@template project_stage_model}
///
/// Model of a stage
///
/// {@endtemplate}
class ProjectStage extends Equatable {

  /// {@macro project_stage_model}
  const ProjectStage({
    this.id,
    required this.projectId,
    required this.name,
  });

  /// Id of the stage
  final String? id;
  /// Id of the project this stage belongs to
  final String projectId;
  /// Name of the stage
  final String name;

  @override
  List<Object?> get props => [id, projectId, name];
}
