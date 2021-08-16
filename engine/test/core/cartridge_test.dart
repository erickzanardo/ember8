import 'package:engine/engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cartridge - EmberStage', () {
    test('copy creates a new reference to the stage', () {
      final original = EmberStage({
        'player': {
          'x': 10,
          'inventory': {
            'weapon': 'sword',
          },
        },
      });

      final copy = original.copy();
      copy.objects['player']?['x'] = 12;
      copy.objects['player']?['inventory']?['weapon'] = 'axe';

      expect(original.objects['player']?['x'], 10);
      expect(original.objects['player']?['inventory']?['weapon'], 'sword');
    });
  });
}
