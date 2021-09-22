import 'package:editor/src/project/models/project.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Project - models - Project', () {
    test('copyWith returns a new instance (scripts)', () {
      const model = Project(name: '');

      const newScript = ProjectScript(
        type: ProjectScriptType.controller,
        name: 'playerController',
        body: '',
      );

      final newModel = model.copyWith(
        scripts: const [
          newScript,
        ],
      );

      final newEqualModel = model.copyWith();

      expect(newModel.scripts, [newScript]);

      expect(newEqualModel, model);
    });

    test('copyWith returns a new instance (sprites)', () {
      const model = Project(name: '');

      const newSprite = ProjectSprite(name: 'player', pixels: [
        [1, 1],
      ]);

      final newModel = model.copyWith(
        sprites: const [
          newSprite,
        ],
      );

      final newEqualModel = model.copyWith();

      expect(newModel.sprites, [newSprite]);

      expect(newEqualModel, model);
    });

    test('copyWith returns a new instance (templates)', () {
      const model = Project(name: '');

      const newTemplate = ProjectTemplate(
        'bullet',
        [
          ProjectTemplateField<String>('script', 'bulletController'),
          ProjectTemplateField<String>('sprite', 'bulletSprite'),
        ],
      );

      final newModel = model.copyWith(
        templates: const [
          newTemplate,
        ],
      );

      final newEqualModel = model.copyWith();

      expect(newModel.templates, [newTemplate]);

      expect(newEqualModel, model);
    });

    test('copyWith returns a new instance (stages)', () {
      const model = Project(name: '');

      const newStage = ProjectStage(
        'title',
        [
          ProjectStageObject(
              name: 'title', templateName: 'titleLabel', x: 0, y: 0),
          ProjectStageObject(
              name: 'playButton', templateName: 'playButton', x: 10, y: 10),
        ],
      );

      final newModel = model.copyWith(
        stages: const [
          newStage,
        ],
      );

      final newEqualModel = model.copyWith();

      expect(newModel.stages, [newStage]);

      expect(newEqualModel, model);
    });

    test('copyWith returns a new instance (name)', () {
      const model = Project(name: '');

      final newModel = model.copyWith(
        name: 'cool name',
      );

      final newEqualModel = model.copyWith();

      expect(newModel.name, 'cool name');

      expect(newEqualModel, model);
    });
  });
}
