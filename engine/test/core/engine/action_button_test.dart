import 'package:engine/engine.dart';
import 'package:flutter_test/flutter_test.dart';

EmberCartridge _createCartridge(
  String actionController, {
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
      EmberActionScript(
        name: 'actionController',
        stage: 'game',
        body: actionController,
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

      // A - Down
      engine.actionEvent(ActionEvent.a, ButtonEvent.down);
      expect(engine.runningStage.objects['player']?['key'], 'a');
      expect(engine.runningStage.objects['player']?['type'], 'down');

      // B - Down
      engine.actionEvent(ActionEvent.b, ButtonEvent.down);
      expect(engine.runningStage.objects['player']?['key'], 'b');
      expect(engine.runningStage.objects['player']?['type'], 'down');

      // A - Up
      engine.actionEvent(ActionEvent.a, ButtonEvent.up);
      expect(engine.runningStage.objects['player']?['key'], 'a');
      expect(engine.runningStage.objects['player']?['type'], 'up');

      // B - Up
      engine.actionEvent(ActionEvent.b, ButtonEvent.up);
      expect(engine.runningStage.objects['player']?['key'], 'b');
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
        engine.actionEvent(ActionEvent.b, ButtonEvent.down);
        expect(engine.runningStage.objects['player']?['key'], isNull);
        expect(engine.runningStage.objects['player']?['type'], isNull);
      });
    });
  });
}
