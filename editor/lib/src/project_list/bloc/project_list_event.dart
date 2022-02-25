part of 'project_list_bloc.dart';

abstract class ProjectListEvent extends Equatable {
  const ProjectListEvent();
}

class ProjectListRequested extends ProjectListEvent {
  const ProjectListRequested();

  @override
  List<Object?> get props => [];
}

class ProjectCreated extends ProjectListEvent {
  const ProjectCreated({
    required this.name,
  });

  final String name;

  @override
  List<Object?> get props => [name];
}

