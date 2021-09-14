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

  List<dynamic> toData() {
    return [name, templateName, x, y];
  }

  static ProjectStageObject fromData(List<dynamic> data) {
    final name = data[0] as String;
    final templateName = data[1] as String;
    final x = data[2] as double;
    final y = data[3] as double;

    return ProjectStageObject(
      name: name,
      templateName: templateName,
      x: x,
      y: y,
    );
  }
}

class ProjectStage extends Equatable {
  final String name;
  final List<ProjectStageObject> objects;

  const ProjectStage(this.name, this.objects);

  @override
  List<Object?> get props => [name, objects];

  List<dynamic> toData() {
    return [
      name,
      objects.map((o) => o.toData()).toList(),
    ];
  }

  static ProjectStage fromData(List<dynamic> data) {
    final name = data[0] as String;
    final objectsData = data[1] as List<List<dynamic>>;
    final objects = objectsData
        .map(
          (data) => ProjectStageObject.fromData(data),
        )
        .toList();

    return ProjectStage(name, objects);
  }
}
