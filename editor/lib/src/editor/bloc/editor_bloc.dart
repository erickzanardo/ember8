import 'package:flutter_bloc/flutter_bloc.dart';

import 'editor_events.dart';
import 'editor_state.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  EditorBloc({
    EditorState initialState = const EditorState(),
  }) : super(initialState);

  @override
  Stream<EditorState> mapEventToState(EditorEvent event) async* {
    if (event is SelectTabEvent) {
      yield state.copyWith(currentTab: event.newTab);
    } else if (event is OpenScriptEvent) {
      if (!state.openScripts.contains(event.scriptName)) {
        yield state.copyWith(
          openScripts: [
            ...state.openScripts,
            event.scriptName,
          ],
          currentOpenScript: event.scriptName,
        );
      } else {
        yield state.copyWith(currentOpenScript: event.scriptName);
      }
    } else if (event is CloseScriptEvent) {
      if (state.openScripts.contains(event.scriptName)) {
        final newScripts = state.openScripts
            .where((script) => script != event.scriptName)
            .toList();
        var currentOpenScript = '';
        if (state.currentOpenScript == event.scriptName &&
            newScripts.isNotEmpty) {
          currentOpenScript = newScripts.last;
        }

        yield state.copyWith(
          openScripts: [...newScripts],
          currentOpenScript: currentOpenScript,
        );
      }
    } else if (event is SelectScriptEvent) {
      if (state.openScripts.contains(event.scriptName)) {
        yield state.copyWith(currentOpenScript: event.scriptName);
      }
    }
  }
}
