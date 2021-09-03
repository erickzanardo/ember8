import 'package:flutter_bloc/flutter_bloc.dart';

import 'workspace_events.dart';
import 'workspace_state.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, WorkspaceState> {
  WorkspaceBloc({
    WorkspaceState initialState = const WorkspaceState(),
  }) : super(initialState) {
    on<OpenEditorEvent>(_handleOpenEditor);
    on<CloseEditorEvent>(_handleCloseEditor);
    on<SelectEditorEvent>(_handleSelectEvent);
  }

  Future<void> _handleOpenEditor(
    OpenEditorEvent event,
    Emitter<WorkspaceState> emit,
  ) async {
    if (!state.openEditors.contains(event.name)) {
      emit(state.copyWith(
        openEditors: [
          ...state.openEditors,
          event.name,
        ],
        currentEditor: event.name,
      ));
    } else {
      emit(state.copyWith(currentEditor: event.name));
    }
  }

  Future<void> _handleCloseEditor(
    CloseEditorEvent event,
    Emitter<WorkspaceState> emit,
  ) async {
    if (state.openEditors.contains(event.name)) {
      final newEditors =
          state.openEditors.where((script) => script != event.name).toList();
      var currentOpenEditor = '';
      if (state.currentEditor == event.name && newEditors.isNotEmpty) {
        currentOpenEditor = newEditors.last;
      }

      emit(state.copyWith(
        openEditors: [...newEditors],
        currentEditor: currentOpenEditor,
      ));
    }
  }

  Future<void> _handleSelectEvent(
    SelectEditorEvent event,
    Emitter<WorkspaceState> emit,
  ) async {
    if (state.openEditors.contains(event.name)) {
      emit(state.copyWith(currentEditor: event.name));
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

class StagesWorkspaceBloc extends WorkspaceBloc {
  StagesWorkspaceBloc({
    WorkspaceState initialState = const WorkspaceState(),
  }) : super(initialState: initialState);
}
