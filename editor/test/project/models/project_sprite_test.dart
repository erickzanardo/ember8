import 'package:editor/src/project/models/project.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Project - models - Project sprite', () {
    const sprite = ProjectSprite(
      name: 'ship',
      pixels: [
        [0, 1],
        [null, 2],
      ],
    );
    const data = [
      'ship',
      [
        [1, 2],
        [0, 3],
      ],
    ];
    test('correctly serializes', () {
      expect(sprite.toData(), equals(data));
    });
    test('correctly deserializes', () {
      expect(ProjectSprite.fromData(data), equals(sprite));
    });
  });
}
