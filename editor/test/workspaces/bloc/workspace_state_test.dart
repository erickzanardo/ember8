import 'package:editor/src/workspaces/bloc/workspace_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Workspace - bloc - WorkspaceState', () {
    test('copyWith returns a new instance (openEditors)', () {
      const state = WorkspaceState();

      final newState = state.copyWith(
        openEditors: ['playerController'],
      );

      final newEqualState = state.copyWith();

      expect(newState.openEditors, ['playerController']);

      expect(newEqualState, state);
      expect(newState, isNot(state));
    });
    test('copyWith returns a new instance (currentEditor)', () {
      const state = WorkspaceState();

      final newState = state.copyWith(currentEditor: 'playerController');

      final newEqualState = state.copyWith();

      expect(newState.currentEditor, 'playerController');

      expect(newEqualState, state);
      expect(newState, isNot(state));
    });
  });
}
