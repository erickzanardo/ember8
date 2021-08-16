import 'package:engine/engine.dart';
import 'package:flutter_test/flutter_test.dart';

EmberCartridge _createCartridge(
  String dpadController, {
  String initialStage = 'game',
}) {
  return EmberCartridge(
    initialStage: initialStage,
    stages: {
      'game': EmberStage(
        {
          'player': {
            'x': 10.0,
            'y': 10.0,
            'script': 'playerController',
            'sprite': 'rectangle',
          },
        },
      ),
      'title': EmberStage({
        'title': {
          'x': 10.0,
          'y': 10.0,
          'sprite': 'rectangle',
        },
      }),
    },
    templates: {
      'bullet': {
        'tag': 'bullet',
      },
    },
    scripts: [
      EmberDpadScript(
        name: 'dpadController',
        stage: 'game',
        body: dpadController,
      )
    ],
  );
}

void main() {
  group('Engine - DpadController', () {
    test('correctly maps the events', () async {
      final cartridge = _createCartridge('''
          let player = get_obj('player')
          player['key'] = key
          player['type'] = type
          ''');

      final engine = EmberCartridgeEngine(
        cartridge,
        onNewObject: (_, __) {},
        onRemoveObject: (_) {},
        onChangeStage: () {},
      );

      await engine.load();

      // Top - Down
      engine.dpadEvent(DpadEvent.top, ButtonEvent.down);
      expect(engine.runningStage.objects['player']?['key'], 'top');
      expect(engine.runningStage.objects['player']?['type'], 'down');

      // Bottom - Down
      engine.dpadEvent(DpadEvent.bottom, ButtonEvent.down);
      expect(engine.runningStage.objects['player']?['key'], 'bottom');
      expect(engine.runningStage.objects['player']?['type'], 'down');

      // Left - Down
      engine.dpadEvent(DpadEvent.left, ButtonEvent.down);
      expect(engine.runningStage.objects['player']?['key'], 'left');
      expect(engine.runningStage.objects['player']?['type'], 'down');

      // Right - Down
      engine.dpadEvent(DpadEvent.right, ButtonEvent.down);
      expect(engine.runningStage.objects['player']?['key'], 'right');
      expect(engine.runningStage.objects['player']?['type'], 'down');

      // Top - Up
      engine.dpadEvent(DpadEvent.top, ButtonEvent.up);
      expect(engine.runningStage.objects['player']?['key'], 'top');
      expect(engine.runningStage.objects['player']?['type'], 'up');

      // Bottom - Up
      engine.dpadEvent(DpadEvent.bottom, ButtonEvent.up);
      expect(engine.runningStage.objects['player']?['key'], 'bottom');
      expect(engine.runningStage.objects['player']?['type'], 'up');

      // Left - Up
      engine.dpadEvent(DpadEvent.left, ButtonEvent.up);
      expect(engine.runningStage.objects['player']?['key'], 'left');
      expect(engine.runningStage.objects['player']?['type'], 'up');

      // Right - Up
      engine.dpadEvent(DpadEvent.right, ButtonEvent.up);
      expect(engine.runningStage.objects['player']?['key'], 'right');
      expect(engine.runningStage.objects['player']?['type'], 'up');
    });

    group('when on different stage than the script', () {
      test('do not run the script', () async {
        final cartridge = _createCartridge('''
          let player = get_obj('player')
          player['key'] = key
          player['type'] = type
          ''', initialStage: 'title');

        final engine = EmberCartridgeEngine(
          cartridge,
          onNewObject: (_, __) {},
          onRemoveObject: (_) {},
          onChangeStage: () {},
        );

        await engine.load();

        // Top - Down
        engine.dpadEvent(DpadEvent.top, ButtonEvent.down);
        expect(engine.runningStage.objects['player']?['key'], isNull);
        expect(engine.runningStage.objects['player']?['type'], isNull);
      });
    });
  });
}
