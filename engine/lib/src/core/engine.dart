import 'package:flame/extensions.dart';
import 'package:hetu_script/hetu_script.dart';

import 'cartridge.dart';
import 'events.dart';
import 'scripts.dart';

class EmberCartridgeEngine {
  static final resolution = Vector2(160, 144);
  final EmberCartridge cartridge;
  final Map<String, Image> sprites = {};
  final Map<String, Hetu> controllers = {};
  final Map<String, Hetu> dpadControllers = {};

  EmberCartridgeEngine(this.cartridge);

  String _mapDpadEvent(DpadEvent event) {
    switch (event) {
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
    switch (event) {
      case ButtonEvent.up:
        return 'up';
      case ButtonEvent.down:
        return 'down';
    }
  }

  void dpadEvent(DpadEvent dpadEvent, ButtonEvent buttonEvent) {
    for (final entry in dpadControllers.entries) {
      final hetu = entry.value;
      hetu.invoke(
        entry.key,
        positionalArgs: [
          _mapDpadEvent(dpadEvent),
          _mapButtonEvent(buttonEvent)
        ],
      );
    }
  }

  Future<void> load() async {
    for (final script in cartridge.scripts) {
      final hetu = Hetu();
      await hetu.init();
      await hetu.eval(script.toString());

      if (script is EmberControllerScript) {
        controllers[script.name] = hetu;
      } else if (script is EmberDpadScript) {
        dpadControllers[script.name] = hetu;
      }
    }

    await Future.wait(
      cartridge.sprites.map((sprite) async {
        sprites[sprite.name] = await sprite.toImage(cartridge.palette);
      }).toList(),
    );
  }

  void tick(double dt) async {
    await Future.wait(cartridge.objects.values
        .where((obj) => obj['script'] != null)
        .map((obj) async {
      final scriptName = obj['script'] as String?;
      final hetu = controllers[scriptName];
      await hetu?.invoke(
        scriptName!,
        positionalArgs: [
          dt,
          obj,
        ],
      );
    }).toList());
  }
}
