import 'package:editor/src/workspaces/bloc/workspace_events.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Workspace - Bloc - Events', () {
    group('OpenEditorEvent', () {
      test('objects with the same script name are equals', () {
        const event1 = OpenEditorEvent('playerController');
        const event2 = OpenEditorEvent('playerController');

        expect(event1, event2);
      });
      test('objects with the different script name are not equals', () {
        const event1 = OpenEditorEvent('playerController');
        const event2 = OpenEditorEvent('bulletController');

        expect(event1, isNot(event2));
      });
    });
    group('CloseEditorEvent', () {
      test('objects with the same script name are equals', () {
        const event1 = CloseEditorEvent('playerController');
        const event2 = CloseEditorEvent('playerController');

        expect(event1, event2);
      });
      test('objects with the different script name are not equals', () {
        const event1 = CloseEditorEvent('playerController');
        const event2 = CloseEditorEvent('bulletController');

        expect(event1, isNot(event2));
      });
    });
    group('SelectEditorEvent', () {
      test('objects with the same script name are equals', () {
        const event1 = SelectEditorEvent('playerController');
        const event2 = SelectEditorEvent('playerController');

        expect(event1, event2);
      });
      test('objects with the different script name are not equals', () {
        const event1 = SelectEditorEvent('playerController');
        const event2 = SelectEditorEvent('bulletController');

        expect(event1, isNot(event2));
      });
    });
  });
}
