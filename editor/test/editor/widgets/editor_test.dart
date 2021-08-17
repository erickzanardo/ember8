import 'package:flutter_test/flutter_test.dart';

import '../../widgets_extensions.dart';

void main() {
  group('Widgets - Editor', () {
    testWidgets('can select tabs', (tester) async {
      await tester.pumpEditor(); 

      // Starts with the scripts tab selected
      expect(
          find.byTabOptions(label: 'Scripts', selected: true),
          findsOneWidget,
      );

      await tester.tap(find.byTabOptions(label: 'Sprites'));
      await tester.pump();

      expect(
          find.byTabOptions(label: 'Sprites', selected: true),
          findsOneWidget,
      );

      await tester.tap(find.byTabOptions(label: 'Stages'));
      await tester.pump();

      expect(
          find.byTabOptions(label: 'Stages', selected: true),
          findsOneWidget,
      );

      await tester.tap(find.byTabOptions(label: 'Scripts'));
      await tester.pump();

      expect(
          find.byTabOptions(label: 'Scripts', selected: true),
          findsOneWidget,
      );
    });
  });
}
