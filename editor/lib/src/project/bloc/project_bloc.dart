import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

import 'project_events.dart';
import 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    ProjectState initialState = const ProjectState(projectId: 'test') // TODO,
  }) : super(initialState) {
    on<NewProjectEvent>(_handleNewProject);
  }

  Future<void> _handleNewProject(
    NewProjectEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(
      state.copyWith(
        project: Project(userId: event.userId, name: event.name,),
      ),
    );
  }
}
