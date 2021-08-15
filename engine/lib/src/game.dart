// palette: https://lospec.com/palette-list/ammo-8

import 'dart:ui';

import 'package:flame/components.dart' hide ActionEvent;
import 'package:flame/game.dart';

import './core/core.dart';

class EmberGameObject extends SpriteComponent with HasGameRef<EmberGame> {
  final String name;
  final Map<String, dynamic> data;

  EmberGameObject({
    required this.name,
    required this.data,
  });

  @override
  Future<void>? onLoad() async {
    final image = gameRef.engine.sprites[data['sprite']];
    if (image != null) {
      sprite = Sprite(image);

      width = image.width.toDouble();
      height = image.height.toDouble();
    }

    x = data['x'] as double;
    y = data['y'] as double;

    data['w'] = width;
    data['h'] = height;
  }

  @override
  void update(double dt) {
    super.update(dt);

    x = data['x'];
    y = data['y'];
  }
}

class EmberBackgroundComponent extends BaseComponent {
  final EmberPalette palette;
  late Paint paint;
  late Rect rect;

  EmberBackgroundComponent(this.palette);

  @override
  Future<void>? onLoad() async {
    paint = Paint()..color = palette.backgroundColor;
    rect = Rect.fromLTWH(
      0,
      0,
      EmberCartridgeEngine.resolution.x,
      EmberCartridgeEngine.resolution.y,
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      rect,
      paint,
    );
  }
}

class EmberGame extends BaseGame {
  final EmberCartridge cartridge;
  late EmberCartridgeEngine engine;

  EmberGame(this.cartridge);

  void sendDpadEvent(DpadEvent dpadEvent, ButtonEvent buttonEvent) {
    engine.dpadEvent(dpadEvent, buttonEvent);
  }

  void sendActionEvent(ActionEvent actionEvent, ButtonEvent buttonEvent) {
    engine.actionEvent(actionEvent, buttonEvent);
  }

  @override
  Future<void> onLoad() async {
    viewport = FixedResolutionViewport(
      EmberCartridgeEngine.resolution,
    );

    add(EmberBackgroundComponent(cartridge.palette));

    engine = EmberCartridgeEngine(
      cartridge,
      onNewObject: (name, data) {
        add(EmberGameObject(name: name, data: data));
      },
      onRemoveObject: (key) {
        components.removeWhere(
            (element) => element is EmberGameObject && element.name == key);
      },
      onChangeStage: () {
        _removeGameObjects();
        _loadStageObjects();
      },
    );
    await engine.load();

    _loadStageObjects();
  }

  void _removeGameObjects() {
    components.removeWhere((element) => element is EmberGameObject);
  }

  void _loadStageObjects() {
    engine.runningStage.objects.forEach((key, value) {
      add(EmberGameObject(name: key, data: value));
    });
  }

  @override
  void update(double dt) {
    engine.tick(dt);
    super.update(dt);
  }
}
