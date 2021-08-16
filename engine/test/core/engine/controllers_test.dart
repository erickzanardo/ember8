import 'package:engine/engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Engine - Controllers', () {
    test('runs objects controllers on tick', () async {
      final cartridge = EmberCartridge(
        initialStage: 'game',
        stages: {
          'game': EmberStage(
            {
              'player': {
                'x': 10,
                'script': 'playerController',
              },
            },
          ),
        },
        scripts: [
          EmberControllerScript(
            name: 'playerController',
            body: '''
              obj['x'] = obj['x'] + dt * 20
              ''',
          )
        ],
      );

      final engine = EmberCartridgeEngine(
        cartridge,
        onNewObject: (_, __) {},
        onRemoveObject: (_) {},
        onChangeStage: () {},
      );

      await engine.load();

      engine.tick(0.1);

      expect(engine.runningStage.objects['player']?['x'], 12);
    });
  });
}
