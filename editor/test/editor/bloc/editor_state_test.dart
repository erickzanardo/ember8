import 'package:editor/src/editor/bloc/editor_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Editor - bloc - EditorState', () {
    test('copyWith returns a new instance (currentTab)', () {
      const state = EditorState();

      final newState = state.copyWith(
        currentTab: EditorTab.sprites,
      );

      final newEqualState = state.copyWith();

      expect(newState.currentTab, EditorTab.sprites);

      expect(newEqualState, state);
    });

    test('copyWith returns a new instance (scripts)', () {
      const state = EditorState();

      const newScript = EditorScript(
        type: EditorScriptType.controller,
        name: 'playerController',
        body: '',
      );

      final newState = state.copyWith(
        scripts: const [
          newScript,
        ],
      );

      final newEqualState = state.copyWith();

      expect(newState.scripts, [newScript]);

      expect(newEqualState, state);
    });
  });
}
