import 'scripts.dart';

import 'graphics.dart';

class EmberCartridge {
  final EmberPalette palette;
  final List<EmberSprite> sprites;
  final List<EmberScript> scripts;
  final Map<String, Map<String, Object>> objects;

  EmberCartridge({
    this.palette = const EmberPalette.base(),
    this.sprites = const [],
    this.scripts = const [],
    this.objects = const {},
  });
}

