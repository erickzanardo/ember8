import 'package:editor/src/project/models/project.dart';
import 'package:equatable/equatable.dart';

class ProjectState extends Equatable {
  final Project project;

  const ProjectState({
    this.project = const Project(),
  });

  @override
  List<Object?> get props => [project];

  ProjectState copyWith({
    Project? project,
  }) {
    return ProjectState(
      project: project ?? this.project,
    );
  }
}
