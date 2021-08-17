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
  });
}

