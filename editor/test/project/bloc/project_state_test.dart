import 'package:editor/src/project/bloc/project_state.dart';
import 'package:editor/src/project/models/project.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Project - bloc - ProjectState', () {
    test('copyWith returns a new instance (project)', () {
      const state = ProjectState();

      const newScript = ProjectScript(
        type: ProjectScriptType.action,
        name: 'action',
        body: 'aa',
      );
      const newProject = Project(
        scripts: [newScript],
      );

      final newState = state.copyWith(
        project: newProject,
      );

      final newEqualState = state.copyWith();

      expect(newState.project, newProject);

      expect(newEqualState, state);
    });
  });
}
