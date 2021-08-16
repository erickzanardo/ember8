import 'package:engine/engine.dart';
import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';

EmberCartridge _createCartridge(
  String playerController, {
  String initialStage = 'game',
}) {
  return EmberCartridge(
    initialStage: initialStage,
    sprites: [
      EmberSprite(
        'square',
        [
          [1, 1],
          [1, 1],
        ],
      ),
      EmberSprite(
        'rectangle',
        [
          [1, 1, 1],
          [1, 1, 1],
        ],
      )
    ],
    stages: {
      'game': EmberStage(
        {
          'player': {
            'x': 10.0,
            'y': 10.0,
            'script': 'playerController',
            'sprite': 'rectangle',
          },
          'enemy1': {
            'x': 10.0,
            'y': 10.0,
            'sprite': 'square',
            'tag': 'enemy',
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
      EmberControllerScript(
        name: 'playerController',
        body: playerController,
      )
    ],
  );
}

void main() {
  group('EmberGame', () {
    test('it correctly loads the initial state', () async {
      final cartridge = _createCartridge('', initialStage: 'title');

      final game = EmberGame(cartridge);
      game.onResize(Vector2.all(100));

      await game.onLoad();
      game.update(0); // Objects are added on the next tick

      expect(game.components.length, 2);
    });

    test('it correctly adds the background component', () async {
      final cartridge = _createCartridge('', initialStage: 'title');

      final game = EmberGame(cartridge);
      game.onResize(Vector2.all(100));

      await game.onLoad();
      game.update(0); // Objects are added on the next tick

      final backgroundComponent = game.components.first;
      expect(backgroundComponent, isA<EmberBackgroundComponent>());

      expect(
        (backgroundComponent as EmberBackgroundComponent).paint.color,
        cartridge.palette.backgroundColor,
      );
    });

    group('when an object is added', () {
      test('it correctly adds the object to the game', () async {
        final cartridge = _createCartridge(
            '''
            create_obj('bullet', 'my_bullet', {'x': 10, 'y': 10 })
            ''',
            initialStage: 'game',
        );

        final game = EmberGame(cartridge);
        game.onResize(Vector2.all(100));

        await game.onLoad();
        game.update(0); // Runs the first tick

        game.update(0); // next tick for the first update

        await Future.delayed(Duration.zero); // Addition is an async call
        game.update(0); // Object is added on the next tick

        expect(game.components.length, 4);
        expect(game.components.last, isA<EmberGameObject>());
        expect((game.components.last as EmberGameObject).name, 'my_bullet');
      });
    });

    group('when an object is removed', () {
      test('it correctly removes the object from the game', () async {
        final cartridge = _createCartridge(
            '''
            remove_obj('enemy1')
            ''',
            initialStage: 'game',
        );

        final game = EmberGame(cartridge);
        game.onResize(Vector2.all(100));

        await game.onLoad();
        game.update(0); // Runs the first tick
        expect(game.components.length, 3);

        game.update(0); // next tick for the first update

        game.update(0); // Object is removed on the next tick

        expect(game.components.length, 2);
      });
    });

    group('when state changes', () {
      test('it correctly changes the objects to match the new stage', () async {
        final cartridge = _createCartridge(
            '''
            enter_stage('title')
            ''',
            initialStage: 'game',
        );

        final game = EmberGame(cartridge);
        game.onResize(Vector2.all(100));

        await game.onLoad();
        game.update(0); // Runs the first tick

        game.update(0); // next tick for the first update

        await Future.delayed(Duration.zero); // Addition is an async call
        game.update(0); // Objects are added and removed on the next tick

        expect(game.components.length, 2);
        expect(game.components.last, isA<EmberGameObject>());
        expect((game.components.last as EmberGameObject).name, 'title');
      });
    });
  });
}
