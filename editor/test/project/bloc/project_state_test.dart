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

    test('copyWith returns a new instance (sprites)', () {
      const state = ProjectState();

      const newSprite = ProjectSprite(
        name: 'player',
        pixels: [
          [1, 1],
        ]
      );

      final newState = state.copyWith(
        sprites: const [
          newSprite,
        ],
      );

      final newEqualState = state.copyWith();

      expect(newState.sprites, [newSprite]);

      expect(newEqualState, state);
    });

    test('copyWith returns a new instance (templates)', () {
      const state = ProjectState();

      const newTemplate = ProjectTemplate(
          'bullet',
          [
            ProjectTemplateField<String>('script', 'bulletController'),
            ProjectTemplateField<String>('sprite', 'bulletSprite'),
          ],
      );

      final newState = state.copyWith(
        templates: const [
          newTemplate,
        ],
      );

      final newEqualState = state.copyWith();

      expect(newState.templates, [newTemplate]);

      expect(newEqualState, state);
    });

    test('copyWith returns a new instance (stages)', () {
      const state = ProjectState();

      const newStage = ProjectStage(
          'title',
          [
            ProjectStageObject(name: 'title', templateName: 'titleLabel', x: 0, y: 0),
            ProjectStageObject(name: 'playButton', templateName: 'playButton', x: 10, y: 10),
          ],
      );

      final newState = state.copyWith(
        stages: const [
          newStage,
        ],
      );

      final newEqualState = state.copyWith();

      expect(newState.stages, [newStage]);

      expect(newEqualState, state);
    });
  });
}
