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
  });
}
