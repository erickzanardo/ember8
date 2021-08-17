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
  });
}

