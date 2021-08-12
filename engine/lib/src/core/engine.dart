import 'package:flame/extensions.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:uuid/uuid.dart';

import 'cartridge.dart';
import 'events.dart';
import 'scripts.dart';

class EmberCartridgeEngine {
  static final resolution = Vector2(160, 144);
  final EmberCartridge cartridge;
  final Map<String, Image> sprites = {};
  final Map<String, Hetu> controllers = {};
  final Map<String, Hetu> dpadControllers = {};
  final Map<String, Hetu> actionControllers = {};
  final void Function(String, Map<String, Object>) onNewObject;
  final void Function(String) onRemoveObject;

  final List<String> _toRemove = [];

  EmberCartridgeEngine(
    this.cartridge, {
    required this.onNewObject,
    required this.onRemoveObject,
  });

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

  String _mapActionEvent(ActionEvent event) {
    switch (event) {
      case ActionEvent.a:
        return 'a';
      case ActionEvent.b:
        return 'b';
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

  void actionEvent(ActionEvent actionEvent, ButtonEvent buttonEvent) {
    for (final entry in actionControllers.entries) {
      final hetu = entry.value;
      hetu.invoke(
        entry.key,
        positionalArgs: [
          _mapActionEvent(actionEvent),
          _mapButtonEvent(buttonEvent)
        ],
      );
    }
  }

  void _createObj(
      String templateName, String objName, Map<dynamic, dynamic> properties) {
    final template = cartridge.templates[templateName];

    if (template == null) {
      throw ArgumentError("Not template named: '$templateName'");
    }

    final Map<String, Object> _castedMap = {};

    properties.entries.forEach((entry) {
      _castedMap[entry.key as String] = entry.value as Object;
    });

    final newObject = {
      ...template,
      ..._castedMap,
    };

    cartridge.objects[objName] = newObject;
    onNewObject(objName, newObject);
  }

  Rect _objRect(Map<String, Object> obj) {
    return Rect.fromLTWH(
      obj['x'] as double,
      obj['y'] as double,
      obj['w'] as double,
      obj['h'] as double,
    );
  }

  Future<void> load() async {
    for (final script in cartridge.scripts) {
      final hetu = Hetu();
      await hetu.init(externalFunctions: {
        'get_obj': (String objName) => cartridge.objects[objName],
        'create_obj': _createObj,
        'create_anonymous_obj':
            (String templateName, Map<dynamic, dynamic> properties) {
          _createObj(templateName, Uuid().v1(), properties);
        },
        'remove_obj': (String objName) {
          _toRemove.add(objName);
        },
        'obj_overlaps': (String objId1, String objId2) {
          final obj1 = cartridge.objects[objId1];
          final obj2 = cartridge.objects[objId2];

          if (obj1 != null && obj2 != null) {
            return _objRect(obj1).overlaps(_objRect(obj2));
          }

          return false;
        },
        'query_objs': (String field, dynamic value) {
          return cartridge.objects.entries
              .where((element) => element.value[field] == value)
              .map((e) => e.key)
              .toList();
        },
      });
      await hetu.eval(script.toString());

      if (script is EmberControllerScript) {
        controllers[script.name] = hetu;
      } else if (script is EmberDpadScript) {
        dpadControllers[script.name] = hetu;
      } else if (script is EmberActionScript) {
        actionControllers[script.name] = hetu;
      }
    }

    await Future.wait(
      cartridge.sprites.map((sprite) async {
        sprites[sprite.name] = await sprite.toImage(cartridge.palette);
      }).toList(),
    );
  }

  void tick(double dt) async {
    if (_toRemove.isNotEmpty) {
      _toRemove.forEach((key) { 
        final obj = cartridge.objects.remove(key);
        if (obj != null) {
          onRemoveObject(key);
        }
      });
      _toRemove.clear();
    }
    await Future.wait(cartridge.objects.entries
        .where((obj) => obj.value['script'] != null)
        .map((obj) async {
      final scriptName = obj.value['script'] as String?;
      final hetu = controllers[scriptName];
      await hetu?.invoke(
        scriptName!,
        positionalArgs: [
          dt,
          obj.value,
          obj.key,
        ],
      );
    }).toList());
  }
}
