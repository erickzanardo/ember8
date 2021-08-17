import 'package:editor/src/project/bloc/project_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Project - bloc - ProjectState', () {
    test('copyWith returns a new instance (scripts)', () {
      const state = ProjectState();

      const newScript = ProjectScript(
        type: ProjectScriptType.controller,
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
