part of 'project.dart';

class ProjectStageObject extends Equatable {
  final String name;
  final String templateName;
  final double x;
  final double y;

  const ProjectStageObject({
    required this.name,
    required this.templateName,
    required this.x,
    required this.y,
  });

  @override
  List<Object?> get props => [name, templateName, x, y];
}

class ProjectStage extends Equatable {
  final String name;
  final List<ProjectStageObject> objects;

  const ProjectStage(this.name, this.objects);

  @override
  List<Object?> get props => [name, objects];
}

