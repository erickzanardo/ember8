import 'package:editor/src/project/models/project.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const objectData = [
    'object',
    'template',
    1.0,
    1.0,
  ];

  const object = ProjectStageObject(
    name: 'object',
    templateName: 'template',
    x: 1.0,
    y: 1.0,
  );

  const stageData = [
    'title',
    [objectData],
  ];

  const stage = ProjectStage('title', [object]);

  group('Project - models - Project Stage Object', () {
    test('correctly serializes', () {
      expect(object.toData(), equals(objectData));
    });
    test('correctly deserializes', () {
      expect(
        ProjectStageObject.fromData(objectData),
        equals(object),
      );
    });
  });

  group('Project - models - Project Stage', () {
    test('correctly serializes', () {
      expect(stage.toData(), equals(stageData));
    });
    test('correctly deserializes', () {
      expect(
        ProjectStage.fromData(stageData),
        equals(stage),
      );
    });
  });
}
