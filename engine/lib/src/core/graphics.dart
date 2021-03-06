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

  // palette: https://lospec.com/palette-list/endesga-8
  const EmberPalette.color()
      : this(const [
          Color(0XFF1B1C33),
          Color(0XFF7B53AD),
          Color(0XFF2D93DD),
          Color(0XFF28C641),
          Color(0XFFE6DA29),
          Color(0XFFDA7D22),
          Color(0XFFD32734),
          Color(0XFFFDFDF8),
        ]);

  Color get backgroundColor => colors.first;
}

class EmberSprite {
  final String name;
  final List<List<int?>> pixels;

  EmberSprite(this.name, this.pixels);

  Future<Image> toImage(EmberPalette palette) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    final height = pixels.length;
    final width = pixels[0].length;

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final pixel = pixels[y][x];
        if (pixel != null) {
          canvas.drawRect(
              Rect.fromLTWH(x.toDouble(), y.toDouble(), 1, 1),
              Paint()..color = palette.colors[pixel],
          );
        }
      }
    }

    final picture = recorder.endRecording();

    return await picture.toImage(width, height);
  }
}
