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
    return build()
        .replaceAll(
          'SCREEN_WIDTH',
          EmberCartridgeEngine.resolution.x.toString(),
        )
        .replaceAll(
          'SCREEN_HEIGHT',
          EmberCartridgeEngine.resolution.y.toString(),
        );
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
      fun $name(dt, obj) {
        $body
      }
    ''';
  }
}

class EmberDpadScript extends EmberScript {
  EmberDpadScript({
    required String name,
    required String body,
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
