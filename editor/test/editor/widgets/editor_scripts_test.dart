import 'package:editor/src/editor/widgets/scripts/scripts_workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../page_objects.dart';
import '../../widgets_extensions.dart';

void main() {
  group('Widgets - Editor - Scripts', () {
    testWidgets('it adds a controller script (the default one)',
        (tester) async {
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

      await ScriptsPageObject(tester)
          .createScript('playerMovement', 'Directional Pad');

      expect(find.text('playerMovement'), findsOneWidget);
      expect(find.text('Empty'), findsNothing);
      expect(find.byIcon(Icons.gamepad), findsOneWidget);
    });

    testWidgets('it adds an action button event script', (tester) async {
      await tester.pumpEditor();

      // Scripts is the initial tab and should show an empty message
      expect(find.text('Empty'), findsOneWidget);

      await ScriptsPageObject(tester)
          .createScript('playerActions', 'Action Button');

      expect(find.text('playerActions'), findsOneWidget);
      expect(find.text('Empty'), findsNothing);
      expect(find.byIcon(Icons.sports_mma), findsOneWidget);
    });

    testWidgets('it can cancel the new script', (tester) async {
      final scriptsPageObject = ScriptsPageObject(tester);

      await tester.pumpEditor();

      // Scripts is the initial tab and should show an empty message
      expect(find.text('Empty'), findsOneWidget);

      await scriptsPageObject.openScriptCreationForm();

      await scriptsPageObject.fillNewScriptName('playerActions');

      await scriptsPageObject.cancelScriptForm();

      expect(find.text('Empty'), findsOneWidget);
    });

    testWidgets('it can open scripts from the sidebar', (tester) async {
      final scriptsPageObject = ScriptsPageObject(tester);

      await tester.pumpEditor();

      // Creates a script first
      await scriptsPageObject.createScript('playerController', 'Controller');
      await scriptsPageObject.createScript('playerMovement', 'Action Button');

      await tester.tap(find.text('playerController'));
      await tester.pumpAndSettle();

      // A tab should have open, with it selected
      expect(
        find.byTabOptions(label: 'playerController', selected: true),
        findsOneWidget,
      );

      await tester.tap(find.text('playerMovement'));
      await tester.pumpAndSettle();

      // A tab should have open, with it selected and the previous should exists still
      // but not selected
      expect(
        find.byTabOptions(label: 'playerMovement', selected: true),
        findsOneWidget,
      );
      expect(
        find.byTabOptions(label: 'playerController', selected: false),
        findsOneWidget,
      );
    });

    testWidgets('it can close open scripts using the icon on the tab', (tester) async {
      final scriptsPageObject = ScriptsPageObject(tester);

      await tester.pumpEditor();

      // Creates a script first
      await scriptsPageObject.createScript('playerController', 'Controller');
      await scriptsPageObject.createScript('playerMovement', 'Action Button');

      await tester.tap(find.text('playerController'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('playerMovement'));
      await tester.pumpAndSettle();

      // Making sure our scripts are open
      expect(
        find.byTabOptions(label: 'playerMovement', selected: true),
        findsOneWidget,
      );
      expect(
        find.byTabOptions(label: 'playerController', selected: false),
        findsOneWidget,
      );

      await tester.tap(find.closeIconFromTabOptions(label: 'playerMovement', selected: true));
      await tester.pumpAndSettle();

      expect(
        find.byTabOptions(label: 'playerMovement', selected: true),
        findsNothing,
      );
    });
    testWidgets('it can change between tabs', (tester) async {
      final scriptsPageObject = ScriptsPageObject(tester);

      await tester.pumpEditor();

      // Creates a script first
      await scriptsPageObject.createScript('playerController', 'Controller');
      await scriptsPageObject.createScript('playerMovement', 'Action Button');

      await tester.tap(find.text('playerController'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('playerMovement'));
      await tester.pumpAndSettle();

      // Making sure our scripts are open
      expect(
        find.byTabOptions(label: 'playerMovement', selected: true),
        findsOneWidget,
      );
      expect(
        find.byTabOptions(label: 'playerController', selected: false),
        findsOneWidget,
      );

      await tester.tap(find.byTabOptions(label: 'playerController', selected: false));
      await tester.pumpAndSettle();

      expect(
        find.byTabOptions(label: 'playerMovement', selected: false),
        findsOneWidget,
      );
      expect(
        find.byTabOptions(label: 'playerController', selected: true),
        findsOneWidget,
      );
    });

    // TODO investigate better why this test don't work
    // it seems that CodeField has some issues and tester.enterText
    // don't work with it
    //testWidgets('it can write code', (tester) async {
    //  final scriptsPageObject = ScriptsPageObject(tester);

    //  await tester.pumpEditor();

    //  // Creates a script first
    //  await scriptsPageObject.createScript('playerController', 'Controller');
    //  await scriptsPageObject.createScript('playerMovement', 'Action Button');

    //  await tester.tap(find.text('playerController'));
    //  await tester.pumpAndSettle();

    //  await tester.enterText(find.byType(CodeField), 'this is some code on the first tab');

    //  await tester.tap(find.text('playerMovement'));
    //  await tester.pumpAndSettle();

    //  await tester.enterText(find.byType(CodeField).last, 'this is some code on the second tab');

    //  await tester.tap(find.text('playerController'));
    //  await tester.pumpAndSettle();

    //  expect(find.text('this is some code on the first tab'), findsOneWidget);

    //  await tester.tap(find.text('playerMovement'));
    //  await tester.pumpAndSettle();

    //  expect(find.text('this is some code on the second tab'), findsOneWidget);
    //});
  });
}
