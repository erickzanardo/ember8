import 'scripts.dart';

import 'graphics.dart';

Map<String, dynamic> _copyMap(Map map) {
  final Map<String, Object> newMap = {};

  for (final entry in map.entries) {
    if (entry.value is Map) {
      newMap[entry.key] = _copyMap(entry.value);
    } else {
      newMap[entry.key] = entry.value;
    }
  }

  return newMap;
}

class EmberStage {
  final Map<String, Map<String, dynamic>> objects;

  EmberStage(this.objects);

  EmberStage copy() => EmberStage({
    ...objects.map((key, value) => MapEntry(key, _copyMap(value))),
  });
}

class EmberCartridge {
  final EmberPalette palette;
  final List<EmberSprite> sprites;
  final List<EmberScript> scripts;
  final Map<String, EmberStage> stages;
  final String initialStage;
  final Map<String, Map<String, Object>> templates;

  EmberCartridge({
    this.palette = const EmberPalette.base(),
    this.sprites = const [],
    this.scripts = const [],
    this.stages = const {},
    required this.initialStage,
    this.templates = const {},
  });
}

