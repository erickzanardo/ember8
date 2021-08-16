import 'package:bloc_test/bloc_test.dart';
import 'package:editor/src/editor/bloc/editor_bloc.dart';
import 'package:editor/src/editor/bloc/editor_events.dart';
import 'package:editor/src/editor/bloc/editor_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Editor - Bloc', () {
    blocTest<EditorBloc, EditorState>(
      'Changes the current tab on SelectTabEvent',
      build: () => EditorBloc(
        initialState: const EditorState(currentTab: EditorTab.stages),
      ),
      act: (bloc) => bloc.add(const SelectTabEvent(EditorTab.sprites)),
      expect: () => [
        const EditorState(currentTab: EditorTab.sprites),
      ],
    );
    blocTest<EditorBloc, EditorState>(
      'Add a new script on NewScriptEvent',
      build: () => EditorBloc(
        initialState: const EditorState(),
      ),
      act: (bloc) => bloc.add(
        const NewScriptEvent(
          'playerController',
          EditorScriptType.controller,
        ),
      ),
      expect: () => [
        const EditorState(scripts: [
          EditorScript(
            type: EditorScriptType.controller,
            name: 'playerController',
            body: '',
          ),
        ]),
      ],
    );
  });
}
