import 'package:flutter_bloc/flutter_bloc.dart';

import 'project_events.dart';
import 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    ProjectState initialState = const ProjectState(),
  }) : super(initialState);

  @override
  Stream<ProjectState> mapEventToState(ProjectEvent event) async* {
    if (event is NewScriptEvent) {
      yield state.copyWith(
          scripts: [
            ...state.scripts,
            ProjectScript(
                type: event.type,
                name: event.name,
                body: '',
            ),
          ],
      );
    }
  }
}

