import 'package:flame/extensions.dart';
import 'package:hetu_script/hetu_script.dart';
import 'package:uuid/uuid.dart';

import 'cartridge.dart';
import 'events.dart';
import 'scripts.dart';

class _ButtonScriptInstance {
  final Hetu hetu;
  final String stage;

  _ButtonScriptInstance(this.hetu, this.stage);
}

class EmberCartridgeEngine {
  static final resolution = Vector2(160, 144);
  final EmberCartridge cartridge;
  final Map<String, Image> sprites = {};
  final Map<String, Hetu> controllers = {};

  final Map<String, _ButtonScriptInstance> dpadControllers = {};
  final Map<String, _ButtonScriptInstance> actionControllers = {};

  final void Function(String, Map<String, dynamic>) onNewObject;
  final void Function(String) onRemoveObject;
  final void Function() onChangeStage;

  late EmberStage runningStage;
  late String currentStage;

  final List<String> _toRemove = [];
  final List<MapEntry<String, Map<String, dynamic>>> _toAdd = [];

  EmberCartridgeEngine(
    this.cartridge, {
    required this.onNewObject,
    required this.onRemoveObject,
    required this.onChangeStage,
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
      if (entry.value.stage == currentStage) {
        final hetu = entry.value.hetu;
        hetu.invoke(
          entry.key,
          positionalArgs: [
            _mapDpadEvent(dpadEvent),
            _mapButtonEvent(buttonEvent)
          ],
        );
      }
    }
  }

  void actionEvent(ActionEvent actionEvent, ButtonEvent buttonEvent) {
    for (final entry in actionControllers.entries) {
      if (entry.value.stage == currentStage) {
        final hetu = entry.value.hetu;
        hetu.invoke(
          entry.key,
          positionalArgs: [
            _mapActionEvent(actionEvent),
            _mapButtonEvent(buttonEvent)
          ],
        );
      }
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

    _toAdd.add(MapEntry(objName, newObject));
  }

  double _objHeight(String objId) {
    final image = sprites[runningStage.objects[objId]?['sprite']];
    return (image?.height ?? 0).toDouble();
  }

  double _objWidth(String objId) {
    final image = sprites[runningStage.objects[objId]?['sprite']];
    return (image?.width ?? 0).toDouble();
  }

  Rect _objRect(Map<String, dynamic> obj) {
    final image = sprites[obj['sprite']];
    return Rect.fromLTWH(
      obj['x'] as double,
      obj['y'] as double,
      (image?.width ?? 0).toDouble(),
      (image?.height ?? 0).toDouble(),
    );
  }

  Future<void> load() async {
    if (!cartridge.stages.containsKey(cartridge.initialStage)) {
      throw ArgumentError("Unknown initial stage '${cartridge.initialStage}'");
    }

    currentStage = cartridge.initialStage;
    runningStage = cartridge.stages[currentStage]!.copy();

    for (final script in cartridge.scripts) {
      final hetu = Hetu();
      await hetu.init(externalFunctions: {
        'get_obj': (String objName) => runningStage.objects[objName],
        'create_obj': _createObj,
        'create_anonymous_obj':
            (String templateName, Map<dynamic, dynamic> properties) {
          _createObj(templateName, Uuid().v1(), properties);
        },
        'remove_obj': (String objName) {
          _toRemove.add(objName);
        },
        'obj_overlaps': (String objId1, String objId2) {
          final obj1 = runningStage.objects[objId1];
          final obj2 = runningStage.objects[objId2];

          if (obj1 != null && obj2 != null) {
            return _objRect(obj1).overlaps(_objRect(obj2));
          }

          return false;
        },
        'query_objs': (String field, dynamic value) {
          return runningStage.objects.entries
              .where((element) => element.value[field] == value)
              .map((e) => e.key)
              .toList();
        },
        'enter_stage': (String newStage) {
          if (cartridge.stages.containsKey(newStage)) {
            currentStage = newStage;
            runningStage = cartridge.stages[currentStage]!.copy();
            onChangeStage();
          }
        },
        'obj_width': _objWidth,
        'obj_height': _objHeight,
      });
      await hetu.eval(script.toString());

      if (script is EmberControllerScript) {
        controllers[script.name] = hetu;
      } else if (script is EmberDpadScript) {
        dpadControllers[script.name] =
            _ButtonScriptInstance(hetu, script.stage);
      } else if (script is EmberActionScript) {
        actionControllers[script.name] =
            _ButtonScriptInstance(hetu, script.stage);
      }
    }

    await Future.wait(
      cartridge.sprites.map((sprite) async {
        sprites[sprite.name] = await sprite.toImage(cartridge.palette);
      }).toList(),
    );
  }

  Future<void> tick(double dt) async {
    if (_toRemove.isNotEmpty) {
      _toRemove.forEach((key) {
        final obj = runningStage.objects.remove(key);
        if (obj != null) {
          onRemoveObject(key);
        }
      });
      _toRemove.clear();
    }

    if (_toAdd.isNotEmpty) {
      _toAdd.forEach((element) {
        runningStage.objects[element.key] = element.value;
        onNewObject(element.key, element.value);
      });
      _toAdd.clear();
    }

    final entries = runningStage.objects.entries;
    await Future.wait(
        entries.where((obj) => obj.value['script'] != null).map((obj) async {
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
