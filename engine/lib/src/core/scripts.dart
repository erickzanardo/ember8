import '../../engine.dart';

abstract class EmberScript {
  final String name;
  final String body;

  EmberScript({
    required this.name,
    required this.body,
  });

  String build();

  @override
  String toString() {
    final script = build()
        .replaceAll(
          'SCREEN_WIDTH',
          EmberCartridgeEngine.resolution.x.toString(),
        )
        .replaceAll(
          'SCREEN_HEIGHT',
          EmberCartridgeEngine.resolution.y.toString(),
        );

    return '''
        external fun get_obj
        external fun create_obj
        external fun create_anonymous_obj
        external fun remove_obj
        external fun obj_overlaps 
        external fun query_objs
        external fun enter_stage
        external fun obj_width 
        external fun obj_height 
        $script
    ''';
  }
}

class EmberControllerScript extends EmberScript {
  EmberControllerScript({
    required String name,
    required String body,
  }) : super(name: name, body: body);

  @override
  String build() {
    return '''
      fun $name(dt, obj, objId) {
        $body
      }
    ''';
  }
}

abstract class EmberButtonScript extends EmberScript {
  final String stage;

  EmberButtonScript({
    required String name,
    required String body,
    required this.stage,
  }) : super(name: name, body: body);

  @override
  String build() {
    return '''
      fun $name(key, type) {
        $body
      }
    ''';
  }
}

class EmberDpadScript extends EmberButtonScript {
  EmberDpadScript({
    required String name,
    required String body,
    required String stage,
  }) : super(name: name, body: body, stage: stage);
}

class EmberActionScript extends EmberButtonScript {
  EmberActionScript({
    required String name,
    required String body,
    required String stage,
  }) : super(name: name, body: body, stage: stage);
}
