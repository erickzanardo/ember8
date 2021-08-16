import 'package:engine/engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hetu_script/hetu_script.dart';

EmberCartridge _createCartridge(String playerController, { String initialStage = 'game', }) {
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
          'enemy2': {
            'x': 20.0,
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
  group('Engine - Controllers', () {
    test('runs objects controllers on tick', () async {
      final cartridge = _createCartridge(
        '''
        obj['x'] = obj['x'] + dt * 20
      ''',
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

    group('when passing an invalid initialStage', () {
      test('throws a exception', () async {
        final cartridge = _createCartridge('', initialStage: 'bla');
        final engine = EmberCartridgeEngine(
            cartridge,
            onNewObject: (_, __) {},
            onRemoveObject: (_) {},
            onChangeStage: () {},
        );

        expect(() => engine.load(), throwsArgumentError);
      });
    });

    group('#get_obj', () {
      test('returns the object with the given id', () async {
      final cartridge = _createCartridge(
        '''
        obj['enemy_x'] = get_obj('enemy2')['x'] 
      ''',
      );
      final engine = EmberCartridgeEngine(
        cartridge,
        onNewObject: (_, __) {},
        onRemoveObject: (_) {},
        onChangeStage: () {},
      );

      await engine.load();

      engine.tick(0.1);

      expect(engine.runningStage.objects['player']?['enemy_x'], 20);
      });
    });

    group('#create_obj', () {
      test('creates a new object on the loaded stage and class onNewObject',
          () async {
        final cartridge = _createCartridge(
          '''
            create_obj('bullet', 'my_bullet', {'x': 10 })
            ''',
        );
        var called = false;

        final engine = EmberCartridgeEngine(
          cartridge,
          onNewObject: (_, __) => called = true,
          onRemoveObject: (_) {},
          onChangeStage: () {},
        );

        await engine.load();

        engine.tick(0.1);
        // Objects are always added on the next tick
        engine.tick(0.1);

        expect(engine.runningStage.objects['my_bullet']?['x'], 10);
        expect(called, isTrue);
      });

      test('throws exception when the template does not exists', () async {
        final cartridge = _createCartridge(
          '''
            create_obj('bla', 'bla', {'x': 10 })
            ''',
        );

        final engine = EmberCartridgeEngine(
          cartridge,
          onNewObject: (_, __) {},
          onRemoveObject: (_) {},
          onChangeStage: () {},
        );

        await engine.load();

        expect(() => engine.tick(0.1), throwsA(isA<HTError>()));
      });
    });

    group('#create_anonymous_obj', () {
      test('creates a new object on the loaded stage and class onNewObject',
          () async {
        final cartridge = _createCartridge(
          '''
            create_anonymous_obj('bullet', {'x': 10 })
            ''',
        );
        var called = false;

        final engine = EmberCartridgeEngine(
          cartridge,
          onNewObject: (_, __) => called = true,
          onRemoveObject: (_) {},
          onChangeStage: () {},
        );

        await engine.load();

        engine.tick(0.1);
        // Objects are always added on the next tick
        engine.tick(0.1);

        expect(engine.runningStage.objects.entries.last.value['x'], 10);
        expect(called, isTrue);
      });

      test('throws exception when the template does not exists', () async {
        final cartridge = _createCartridge(
          '''
            create_anonymous_obj('bla', {'x': 10 })
            ''',
        );

        final engine = EmberCartridgeEngine(
          cartridge,
          onNewObject: (_, __) {},
          onRemoveObject: (_) {},
          onChangeStage: () {},
        );

        await engine.load();

        expect(() => engine.tick(0.1), throwsA(isA<HTError>()));
      });
    });

    group('#remove_obj', () {
      test('removes an object from the running stage and call the listener', () async {
        String? removed;
        final cartridge = _createCartridge(
          '''
            remove_obj('enemy1')
            ''',
        );

        final engine = EmberCartridgeEngine(
          cartridge,
          onNewObject: (_, __) {},
          onRemoveObject: (id) => removed = id,
          onChangeStage: () {},
        );
        await engine.load();

        engine.tick(0.1);
        // Objects are always removed on the next tick
        engine.tick(0.1);

        expect(engine.runningStage.objects['enemy1'], isNull);
        expect(removed, 'enemy1');
      });
    });

    group('#obj_overlaps', () {
      test('returns true if objects are overlaping', () async {
        final cartridge = _createCartridge(
          '''
          obj['overlaps_with_1'] = obj_overlaps(objId, 'enemy1')
          obj['overlaps_with_2'] = obj_overlaps(objId, 'enemy2')
            ''',
        );

        final engine = EmberCartridgeEngine(
          cartridge,
          onNewObject: (_, __) {},
          onRemoveObject: (_) {},
          onChangeStage: () {},
        );
        await engine.load();

        engine.tick(0.1);

        expect(engine.runningStage.objects['player']?['overlaps_with_1'], isTrue);
        expect(engine.runningStage.objects['player']?['overlaps_with_2'], isFalse);
      });
    });

    group('#obj_width/#obj_height', () {
      test('returns width and height of its sprite', () async {
        final cartridge = _createCartridge(
          '''
          obj['w'] = obj_width(objId)
          obj['h'] = obj_height(objId)
            ''',
        );

        final engine = EmberCartridgeEngine(
          cartridge,
          onNewObject: (_, __) {},
          onRemoveObject: (_) {},
          onChangeStage: () {},
        );
        await engine.load();

        engine.tick(0.1);

        expect(engine.runningStage.objects['player']?['w'], 3.0);
        expect(engine.runningStage.objects['player']?['h'], 2.0);
      });
    });

    group('#query_objs', () {
      test('returns objects that match the field query', () async {
        final cartridge = _createCartridge(
          '''
          obj['enemy_count'] = query_objs('tag', 'enemy').length
            ''',
        );

        final engine = EmberCartridgeEngine(
          cartridge,
          onNewObject: (_, __) {},
          onRemoveObject: (_) {},
          onChangeStage: () {},
        );
        await engine.load();

        engine.tick(0.1);

        expect(engine.runningStage.objects['player']?['enemy_count'], 2);
      });
    });
    group('#enter_stage', () {
      test('changes the current stage and calls the listener', () async {
        final cartridge = _createCartridge(
          '''
          enter_stage('title')
            ''',
        );

        var called = false;

        final engine = EmberCartridgeEngine(
          cartridge,
          onNewObject: (_, __) {},
          onRemoveObject: (_) {},
          onChangeStage: () => called = true,
        );
        await engine.load();

        engine.tick(0.1);

        expect(engine.runningStage.objects['title'], isNotNull);
        expect(called, isTrue);
      });
    });
  });
}
