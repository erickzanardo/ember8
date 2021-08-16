import 'package:editor/src/editor/widgets/scripts/scripts_workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'extensions.dart';

void main() {
  group('Widgets - Editor - Scripts', () {
    testWidgets('it adds a controller script (the default one)', (tester) async {
      await tester.pumpEditor(); 

      // Scripts is the initial tab and should show an empty message
      expect(find.text('Empty'), findsOneWidget);

      await tester.tap(find.byKey(ScriptsWorkspace.newScriptKey));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'playerController');

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('playerController'), findsOneWidget);
      expect(find.text('Empty'), findsNothing);
      expect(find.byIcon(Icons.computer), findsOneWidget);
    });

    testWidgets('it adds a directional pad script', (tester) async {
      await tester.pumpEditor(); 

      // Scripts is the initial tab and should show an empty message
      expect(find.text('Empty'), findsOneWidget);

      await tester.tap(find.byKey(ScriptsWorkspace.newScriptKey));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'playerMovement');

      await tester.tap(find.text('Controller'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Directional Pad').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('playerMovement'), findsOneWidget);
      expect(find.text('Empty'), findsNothing);
      expect(find.byIcon(Icons.gamepad), findsOneWidget);
    });

    testWidgets('it adds an action button event script', (tester) async {
      await tester.pumpEditor(); 

      // Scripts is the initial tab and should show an empty message
      expect(find.text('Empty'), findsOneWidget);

      await tester.tap(find.byKey(ScriptsWorkspace.newScriptKey));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'playerActions');

      await tester.tap(find.text('Controller'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Action Button').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('playerActions'), findsOneWidget);
      expect(find.text('Empty'), findsNothing);
      expect(find.byIcon(Icons.sports_mma), findsOneWidget);
    });

    testWidgets('it can cancel the new script', (tester) async {
      await tester.pumpEditor(); 

      // Scripts is the initial tab and should show an empty message
      expect(find.text('Empty'), findsOneWidget);

      await tester.tap(find.byKey(ScriptsWorkspace.newScriptKey));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'playerActions');

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.text('Empty'), findsOneWidget);
    });
  });
}
