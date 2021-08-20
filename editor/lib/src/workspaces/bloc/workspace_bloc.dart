import 'package:flutter_bloc/flutter_bloc.dart';

import 'workspace_events.dart';
import 'workspace_state.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, WorkspaceState> {
  WorkspaceBloc({
    WorkspaceState initialState = const WorkspaceState(),
  }) : super(initialState);

  @override
  Stream<WorkspaceState> mapEventToState(WorkspaceEvent event) async* {
    if (event is OpenEditorEvent) {
      if (!state.openEditors.contains(event.name)) {
        yield state.copyWith(
          openEditors: [
            ...state.openEditors,
            event.name,
          ],
          currentEditor: event.name,
        );
      } else {
        yield state.copyWith(currentEditor: event.name);
      }
    } else if (event is CloseEditorEvent) {
      if (state.openEditors.contains(event.name)) {
        final newEditors = state.openEditors
            .where((script) => script != event.name)
            .toList();
        var currentOpenEditor = '';
        if (state.currentEditor == event.name &&
            newEditors.isNotEmpty) {
          currentOpenEditor = newEditors.last;
        }

        yield state.copyWith(
          openEditors: [...newEditors],
          currentEditor: currentOpenEditor,
        );
      }
    } else if (event is SelectEditorEvent) {
      if (state.openEditors.contains(event.name)) {
        yield state.copyWith(currentEditor: event.name);
      }
    }
  }
}

class ScriptsWorkspaceBloc extends WorkspaceBloc {
  ScriptsWorkspaceBloc({
    WorkspaceState initialState = const WorkspaceState(),
  }) : super(initialState: initialState);
}

class SpritesWorkspaceBloc extends WorkspaceBloc {
  SpritesWorkspaceBloc({
    WorkspaceState initialState = const WorkspaceState(),
  }) : super(initialState: initialState);
}

class TemplatesWorkspaceBloc extends WorkspaceBloc {
  TemplatesWorkspaceBloc({
    WorkspaceState initialState = const WorkspaceState(),
  }) : super(initialState: initialState);
}

