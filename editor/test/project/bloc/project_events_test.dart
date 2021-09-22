import 'package:editor/src/project/bloc/project_events.dart';
import 'package:editor/src/project/models/project.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Project - Bloc - Events', () {
    group('NewProjectEvent', () {
      test('objects with the same name are equal', () {
        const event1 = NewProjectEvent(name: 'game');
        const event2 = NewProjectEvent(name: 'game');

        expect(event1, event2);
      });
    });
    group('NewScriptEvent', () {
      test('objects with the same name and type are equal', () {
        const event1 =
            NewScriptEvent('playerController', ProjectScriptType.controller);
        const event2 =
            NewScriptEvent('playerController', ProjectScriptType.controller);

        expect(event1, event2);
      });
      test('objects with the different newTab are not equals', () {
        var event1 = const NewScriptEvent(
            'playerController', ProjectScriptType.controller);
        var event2 =
            const NewScriptEvent('playerController', ProjectScriptType.dpad);

        expect(event1, isNot(event2));

        event1 = const NewScriptEvent(
            'playerController', ProjectScriptType.controller);
        event2 =
            const NewScriptEvent('blaController', ProjectScriptType.controller);

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
        var event1 =
            const NewSpriteEvent(name: 'player', width: 10, height: 10);
        var event2 =
            const NewSpriteEvent(name: 'bullet', width: 10, height: 10);

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
        const event1 =
            PaintSpritePixelEvent(spriteName: 'player', x: 1, y: 1, color: 1);
        const event2 =
            PaintSpritePixelEvent(spriteName: 'player', x: 1, y: 1, color: 1);

        expect(event1, event2);
      });
      test('objects with the different attributes are not equals', () {
        var event1 = const PaintSpritePixelEvent(
            spriteName: 'bullet', x: 1, y: 1, color: 1);
        var event2 = const PaintSpritePixelEvent(
            spriteName: 'player', x: 1, y: 1, color: 1);

        expect(event1, isNot(event2));

        event1 = const PaintSpritePixelEvent(
            spriteName: 'player', x: 2, y: 1, color: 1);
        event2 = const PaintSpritePixelEvent(
            spriteName: 'player', x: 1, y: 1, color: 1);

        expect(event1, isNot(event2));

        event1 = const PaintSpritePixelEvent(
            spriteName: 'player', x: 1, y: 2, color: 1);
        event2 = const PaintSpritePixelEvent(
            spriteName: 'player', x: 1, y: 1, color: 1);

        expect(event1, isNot(event2));

        event1 = const PaintSpritePixelEvent(
            spriteName: 'player', x: 1, y: 1, color: 0);
        event2 = const PaintSpritePixelEvent(
            spriteName: 'player', x: 1, y: 1, color: 1);

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

    group('AddFieldTemplateEvent', () {
      test('objects with the same name and value are equal', () {
        const event1 = AddFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletController');
        const event2 = AddFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletController');

        expect(event1, event2);
      });
      test('objects with the different name or value are not equals', () {
        var event1 = const AddFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletController');
        var event2 = const AddFieldTemplateEvent<String>(
            'bullet', 'sprite', 'bulletController');

        expect(event1, isNot(event2));

        event1 = const AddFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletController');
        event2 = const AddFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletMovement');

        expect(event1, isNot(event2));

        event1 = const AddFieldTemplateEvent<String>(
            'enemy', 'script', 'bulletController');
        event2 = const AddFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletController');

        expect(event1, isNot(event2));
      });
      test(
          'toProjectTemplateField returns a copy of the event as the state model',
          () {
        const event =
            AddFieldTemplateEvent<String>('enemy', 'script', 'enemyController');

        expect(
          event.toProjectTemplateField(),
          const ProjectTemplateField<String>('script', 'enemyController'),
        );
      });
    });

    group('UpdateFieldTemplateEvent', () {
      test('objects with the same name and value are equal', () {
        const event1 = UpdateFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletController');
        const event2 = UpdateFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletController');

        expect(event1, event2);
      });
      test('objects with the different name or value are not equals', () {
        var event1 = const UpdateFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletController');
        var event2 = const UpdateFieldTemplateEvent<String>(
            'bullet', 'sprite', 'bulletController');

        expect(event1, isNot(event2));

        event1 = const UpdateFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletController');
        event2 = const UpdateFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletMovement');

        expect(event1, isNot(event2));

        event1 = const UpdateFieldTemplateEvent<String>(
            'enemy', 'script', 'bulletController');
        event2 = const UpdateFieldTemplateEvent<String>(
            'bullet', 'script', 'bulletController');

        expect(event1, isNot(event2));
      });
    });
    group('RemoveFieldTemplateEvent', () {
      test('objects with the same templateName and fieldName are equal', () {
        const event1 = RemoveFieldTemplateEvent('bullet', 'script');
        const event2 = RemoveFieldTemplateEvent('bullet', 'script');

        expect(event1, event2);
      });
      test('objects with the different name or value are not equals', () {
        var event1 = const RemoveFieldTemplateEvent('bullet', 'script');
        var event2 = const RemoveFieldTemplateEvent('bullet', 'sprite');

        expect(event1, isNot(event2));

        event1 = const RemoveFieldTemplateEvent('bullet', 'script');
        event2 = const RemoveFieldTemplateEvent('enemy', 'script');
      });
    });
    group('NewStageEvent', () {
      test('objects with the same name are equal', () {
        const event1 = NewStageEvent('title');
        const event2 = NewStageEvent('title');

        expect(event1, event2);
      });
      test('objects with the different name are not equals', () {
        const event1 = NewStageEvent('title');
        const event2 = NewStageEvent('game');

        expect(event1, isNot(event2));
      });
    });
  });
}
