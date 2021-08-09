import 'dart:ui';

import 'package:flame/extensions.dart';
import 'package:hetu_script/hetu_script.dart';

enum DpadEvent {
  top,
  bottom,
  left,
  right,
}

enum ButtonEvent {
  down,
  up,
}

class EmberPalette {
  final List<Color> colors;

  const EmberPalette(this.colors);

// palette: https://lospec.com/palette-list/ammo-8
  const EmberPalette.base()
      : this(const [
          Color(0XFF040C06),
          Color(0XFF112318),
          Color(0XFF1E3A29),
          Color(0XFF305D42),
          Color(0XFF4D8061),
          Color(0XFF89A257),
          Color(0XFFBEDC7F),
          Color(0XFFEEFFCC),
        ]);

  Color get backgroundColor => colors.first;
}

class EmberSprite {
  final String name;
  final List<List<int>> pixels;

  EmberSprite(this.name, this.pixels);
}

class EmberCartridge {
  final EmberPalette palette;
  final List<EmberSprite> sprites;
  final List<String> scripts;
  final Map<String, Map<String, Object>> objects;
  final String? dpadScript;

  EmberCartridge({
    this.palette = const EmberPalette.base(),
    this.sprites = const [],
    this.scripts = const [],
    this.objects = const {},
    this.dpadScript,
  });
}

class EmberCartridgeEngine {
  static final resolution = Vector2(160, 144);
  final EmberCartridge cartridge;
  final Map<String, Image> sprites = {};
  late Hetu hetu;

  EmberCartridgeEngine(this.cartridge);

  String _parseGlobals(String script) {
    return script
        .replaceAll(
          'SCREEN_WIDTH',
          EmberCartridgeEngine.resolution.x.toString(),
        )
        .replaceAll(
          'SCREEN_HEIGHT',
          EmberCartridgeEngine.resolution.y.toString(),
        );
  }

  String _mapDpadEvent(DpadEvent event) {
    switch(event) {
      case DpadEvent.top:
        return 'top';
      case DpadEvent.left:
        return 'left';
      case DpadEvent.right:
        return 'right';
      case DpadEvent.bottom:
        return 'bottom';
    }
  }

  String _mapButtonEvent(ButtonEvent event) {
    switch(event) {
      case ButtonEvent.up:
        return 'up';
      case ButtonEvent.down:
        return 'down';
    }
  }

  void dpadEvent(DpadEvent dpadEvent, ButtonEvent buttonEvent) {
    if (cartridge.dpadScript != null) {
      hetu.invoke(
          'dpadHandler',
          positionalArgs: [_mapDpadEvent(dpadEvent), _mapButtonEvent(buttonEvent)],
      );
    }
  }

  Future<void> load() async {
    hetu = Hetu();
    await hetu.init();

    await Future.wait([
      if (cartridge.dpadScript != null)
        hetu.eval(cartridge.dpadScript!),

      ...cartridge.scripts.map((script) async {
        await hetu.eval(_parseGlobals(script));
      }).toList(),
    ]);

    await Future.wait(
      cartridge.sprites.map((sprite) async {
        final recorder = PictureRecorder();
        final canvas = Canvas(recorder);

        final height = sprite.pixels.length;
        final width = sprite.pixels[0].length;

        for (int y = 0; y < height; y++) {
          for (int x = 0; x < width; x++) {
            canvas.drawRect(
              Rect.fromLTWH(x.toDouble(), y.toDouble(), 1, 1),
              Paint()..color = cartridge.palette.colors[sprite.pixels[y][x]],
            );
          }
        }

        final picture = recorder.endRecording();

        sprites[sprite.name] = await picture.toImage(width, height);
      }).toList(),
    );
  }

  void tick(double dt) async {
    await Future.wait(cartridge.objects.values
        .where((obj) => obj['script'] != null)
        .map((obj) async {
      final scriptName = obj['script'] as String?;
      await hetu.invoke(
        scriptName!,
        positionalArgs: [
          dt,
          obj,
        ],
      );
    }).toList());
  }
}
