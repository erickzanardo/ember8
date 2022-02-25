part of 'project_list_bloc.dart';

enum ProjectListStateStatus {
  initial,
  loading,
  success,
  failure,
}

class ProjectListState extends Equatable {
  const ProjectListState({
    required this.status,
    required this.projects,
  });

  const ProjectListState.initial()
      : this(
          status: ProjectListStateStatus.initial,
          projects: const [],
        );

  final ProjectListStateStatus status;
  final List<Project> projects;

  @override
  List<Object> get props => [status, projects];

  ProjectListState copyWith({
    ProjectListStateStatus? status,
    List<Project>? projects,
  }) {
    return ProjectListState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
    );
  }
}
