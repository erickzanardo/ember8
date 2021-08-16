import 'package:engine/engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Palette', () {
    test('#backgrondColor is the first color of the palette', () {
      final palette = EmberPalette.base();
      expect(palette.backgroundColor, palette.colors.first);
    });
  });
}
