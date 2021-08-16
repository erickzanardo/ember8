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
    }
  }
}
