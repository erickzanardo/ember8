import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';

part 'project_list_event.dart';
part 'project_list_state.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  ProjectListBloc({
    required String userId,
    required ProjectRepository projectRepository,
  })  : _userId = userId,
        _projectRepository = projectRepository,
        super(const ProjectListState.initial()) {
    on<ProjectListRequested>(_onProjectListRequested);
    on<ProjectCreated>(_onProjectCreated);
  }

  final String _userId;
  final ProjectRepository _projectRepository;

  Future<void> _onProjectListRequested(
    ProjectListRequested event,
    Emitter<ProjectListState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ProjectListStateStatus.loading));

      final projects = await _projectRepository.fetchUserProjects(_userId);

      emit(
        state.copyWith(
          status: ProjectListStateStatus.success,
          projects: projects,
        ),
      );
    } catch (e, s) {
      emit(state.copyWith(status: ProjectListStateStatus.failure));
      addError(e, s);
    }
  }

  Future<void> _onProjectCreated(
    ProjectCreated event,
    Emitter<ProjectListState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ProjectListStateStatus.loading));

      final project = await _projectRepository
          .add(Project(userId: _userId, name: event.name));

      emit(
        state.copyWith(
          status: ProjectListStateStatus.success,
          projects: [
            ...state.projects,
            project,
          ],
        ),
      );
    } catch (e, s) {
      addError(e, s);
    }
  }
}
