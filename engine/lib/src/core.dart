import 'dart:ui';

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
  final Map<String, Map<String, Object>> objects;

  EmberCartridge({
    this.palette = const EmberPalette.base(),
    this.sprites = const [],
    this.objects = const {},
  });
}

class EmberCartridgeEngine {
  final EmberCartridge cartridge;
  final Map<String, Image> sprites = {};

  EmberCartridgeEngine(this.cartridge);

  Future<void> load() async {
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
}

