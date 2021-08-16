import 'package:editor/src/editor/bloc/editor_events.dart';
import 'package:editor/src/editor/bloc/editor_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Editor - Bloc - Events', () {
    group('SelectTabEvent', () {
      test('objects with the same newTab are equals', () {
        const event1 = SelectTabEvent(EditorTab.stages);
        const event2 = SelectTabEvent(EditorTab.stages);

        expect(event1, event2);
      });
      test('objects with the different newTab are not equals', () {
        const event1 = SelectTabEvent(EditorTab.stages);
        const event2 = SelectTabEvent(EditorTab.sprites);

        expect(event1, isNot(event2));
      });
    });
    group('NewScriptEvent', () {
      test('objects with the same name and type are equal', () {
        const event1 = NewScriptEvent('playerController', EditorScriptType.controller);
        const event2 = NewScriptEvent('playerController', EditorScriptType.controller);

        expect(event1, event2);
      });
      test('objects with the different newTab are not equals', () {
        var event1 = const NewScriptEvent('playerController', EditorScriptType.controller);
        var event2 = const NewScriptEvent('playerController', EditorScriptType.dpad);

        expect(event1, isNot(event2));

        event1 = const NewScriptEvent('playerController', EditorScriptType.controller);
        event2 = const NewScriptEvent('blaController', EditorScriptType.controller);

        expect(event1, isNot(event2));
      });
    });
  });
}
