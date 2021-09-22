import 'package:editor/src/project/models/project.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Project - models - Project Template Field', () {
    group('double fields', () {
      test('correctly serializes', () {
        const field = ProjectTemplateField<double>('field', 0.2);
        expect(field.toData(), equals(['field', 0.2, 'D']));
      });
      test('correctly deserializes', () {
        const data = ['field', 0.2, 'D'];
        const field = ProjectTemplateField<double>('field', 0.2);
        final generatedField = ProjectTemplateField.fromData(data);

        expect(generatedField, equals(field));
        expect(generatedField, isA<ProjectTemplateField<double>>());
      });
    });
    group('bool fields', () {
      test('correctly serializes', () {
        const field = ProjectTemplateField<bool>('field', true);
        expect(field.toData(), equals(['field', true, 'B']));
      });
      test('correctly deserializes', () {
        const data = ['field', true, 'B'];
        const field = ProjectTemplateField<bool>('field', true);
        final generatedField = ProjectTemplateField.fromData(data);

        expect(generatedField, equals(field));
        expect(generatedField, isA<ProjectTemplateField<bool>>());
      });
    });
    group('String fields', () {
      test('correctly serializes', () {
        const field = ProjectTemplateField<String>('field', 'value');
        expect(field.toData(), equals(['field', 'value', 'S']));
      });
      test('correctly deserializes', () {
        const data = ['field', 'value', 'S'];
        const field = ProjectTemplateField<String>('field', 'value');
        final generatedField = ProjectTemplateField.fromData(data);

        expect(generatedField, equals(field));
        expect(generatedField, isA<ProjectTemplateField<String>>());
      });
    });
  });
  group('Project - models - Project Template', () {
    test('correctly serializes', () {
      const field = ProjectTemplateField<String>('field', 'value');
      const template = ProjectTemplate('template', [field]);
      expect(
          template.toData(),
          equals([
            'template',
            [field.toData()],
          ]));
    });
    test('correctly deserializes', () {
      const field = ProjectTemplateField<String>('field', 'value');
      final data = [
        'template',
        [field.toData()],
      ];
      const template = ProjectTemplate('template', [field]);

      expect(ProjectTemplate.fromData(data), equals(template));
    });
  });
}
