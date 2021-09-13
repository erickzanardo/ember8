import 'package:editor/src/project/models/project.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Project - models - Project Script', () {
    group('when it is a controller', () {
      const script = ProjectScript(
        type: ProjectScriptType.controller,
        name: 'name',
        body: 'body',
      );
      const data = [
        'C',
        'name',
        'body',
      ];

      test('correctly serializes', () {
        expect(script.toData(), equals(data));
      });
      test('correctly deserializes', () {
        expect(ProjectScript.fromData(data), equals(script));
      });
    });
    group('when it is a dpad', () {
      const script = ProjectScript(
        type: ProjectScriptType.dpad,
        name: 'name',
        body: 'body',
      );
      const data = [
        'D',
        'name',
        'body',
      ];
      test('correctly serializes', () {
        expect(script.toData(), equals(data));
      });
      test('correctly deserializes', () {
        expect(ProjectScript.fromData(data), equals(script));
      });
    });
    group('when it is an action', () {
      const script = ProjectScript(
        type: ProjectScriptType.action,
        name: 'name',
        body: 'body',
      );
      const data = [
        'A',
        'name',
        'body',
      ];
      test('correctly serializes', () {
        expect(script.toData(), equals(data));
      });
      test('correctly deserializes', () {
        expect(ProjectScript.fromData(data), equals(script));
      });
    });
  });
}
