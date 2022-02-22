import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';

class ProjectState extends Equatable {
  final String projectId;
  final Project? project;

  const ProjectState({
    this.project,
    required this.projectId,
  });

  @override
  List<Object?> get props => [project];

  ProjectState copyWith({
    Project? project,
  }) {
    return ProjectState(
      projectId: projectId,
      project: project ?? this.project,
    );
  }
}
