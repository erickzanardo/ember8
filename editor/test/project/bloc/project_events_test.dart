import 'package:editor/src/project/bloc/project_events.dart';
import 'package:editor/src/project/bloc/project_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Project - Bloc - Events', () {
    group('NewScriptEvent', () {
      test('objects with the same name and type are equal', () {
        const event1 = NewScriptEvent('playerController', ProjectScriptType.controller);
        const event2 = NewScriptEvent('playerController', ProjectScriptType.controller);

        expect(event1, event2);
      });
      test('objects with the different newTab are not equals', () {
        var event1 = const NewScriptEvent('playerController', ProjectScriptType.controller);
        var event2 = const NewScriptEvent('playerController', ProjectScriptType.dpad);

        expect(event1, isNot(event2));

        event1 = const NewScriptEvent('playerController', ProjectScriptType.controller);
        event2 = const NewScriptEvent('blaController', ProjectScriptType.controller);

        expect(event1, isNot(event2));
      });
    });

    group('UpdateScriptEvent', () {
      test('objects with the same name and code are equal', () {
        const event1 = UpdateScriptEvent('playerController', 'bla');
        const event2 = UpdateScriptEvent('playerController', 'bla');

        expect(event1, event2);
      });
      test('objects with the different name and code are not equals', () {
        var event1 = const UpdateScriptEvent('playerController', 'bla');
        var event2 = const UpdateScriptEvent('playerController', 'ble');

        expect(event1, isNot(event2));

        event1 = const UpdateScriptEvent('playerController', 'bla');
        event2 = const UpdateScriptEvent('blaController', 'bla');

        expect(event1, isNot(event2));
      });
    });

    group('NewSpriteEvent', () {
      test('objects with the same attribute values are equal', () {
        const event1 = NewSpriteEvent(name: 'player', width: 10, height: 10);
        const event2 = NewSpriteEvent(name: 'player', width: 10, height: 10);

        expect(event1, event2);
      });
      test('objects with the different attributes are not equals', () {
        var event1 = const NewSpriteEvent(name: 'player', width: 10, height: 10);
        var event2 = const NewSpriteEvent(name: 'bullet', width: 10, height: 10);

        expect(event1, isNot(event2));

        event1 = const NewSpriteEvent(name: 'player', width: 10, height: 10);
        event2 = const NewSpriteEvent(name: 'player', width: 12, height: 10);

        expect(event1, isNot(event2));

        event1 = const NewSpriteEvent(name: 'player', width: 10, height: 10);
        event2 = const NewSpriteEvent(name: 'player', width: 10, height: 12);

        expect(event1, isNot(event2));
      });
    });

    group('PaintSpritePixelEvent', () {
      test('objects with the same attribute values are equal', () {
        const event1 = PaintSpritePixelEvent(spriteName: 'player', x: 1, y: 1, color: 1);
        const event2 = PaintSpritePixelEvent(spriteName: 'player', x: 1, y: 1, color: 1);

        expect(event1, event2);
      });
      test('objects with the different attributes are not equals', () {
        var event1 = const PaintSpritePixelEvent(spriteName: 'bullet', x: 1, y: 1, color: 1);
        var event2 = const PaintSpritePixelEvent(spriteName: 'player', x: 1, y: 1, color: 1);

        expect(event1, isNot(event2));

        event1 = const PaintSpritePixelEvent(spriteName: 'player', x: 2, y: 1, color: 1);
        event2 = const PaintSpritePixelEvent(spriteName: 'player', x: 1, y: 1, color: 1);

        expect(event1, isNot(event2));

        event1 = const PaintSpritePixelEvent(spriteName: 'player', x: 1, y: 2, color: 1);
        event2 = const PaintSpritePixelEvent(spriteName: 'player', x: 1, y: 1, color: 1);

        expect(event1, isNot(event2));

        event1 = const PaintSpritePixelEvent(spriteName: 'player', x: 1, y: 1, color: 0);
        event2 = const PaintSpritePixelEvent(spriteName: 'player', x: 1, y: 1, color: 1);

        expect(event1, isNot(event2));
      });
    });

    group('NewTemplateEvent', () {
      test('objects with the same name are equal', () {
        const event1 = NewTemplateEvent('bullet');
        const event2 = NewTemplateEvent('bullet');

        expect(event1, event2);
      });
      test('objects with the different name are not equals', () {
        const event1 = NewTemplateEvent('bullet');
        const event2 = NewTemplateEvent('enemy');

        expect(event1, isNot(event2));
      });
    });
  });
}

