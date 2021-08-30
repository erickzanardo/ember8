import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../page_objects.dart';
import '../../../widgets_extensions.dart';

void main() {
  group('Widgets - Editor - Stages', () {
    testWidgets('it adds a stage',
        (tester) async {
      await tester.pumpEditor();

      await EditorPageObject(tester).openStageTab();

      // No stages should exists
      expect(find.text('Empty'), findsOneWidget);

      final stagePageObject = StagesPageObject(tester);
      await stagePageObject.openStagesCreationForm();

      await tester.enterText(find.byType(TextField), 'game');

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.byTabOptions(label: 'game', selected: true), findsOneWidget);
      expect(find.sideBarItemWithText('game'), findsOneWidget);
      expect(find.text('Empty'), findsNothing);
    });

    testWidgets('it can cancel the new stage',
        (tester) async {
      await tester.pumpEditor();

      await EditorPageObject(tester).openStageTab();

      // No stages should exists
      expect(find.text('Empty'), findsOneWidget);

      final stagePageObject = StagesPageObject(tester);
      await stagePageObject.openStagesCreationForm();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.text('Empty'), findsOneWidget);
    });

    testWidgets('it can open stage from the sidebar', (tester) async {
      final stagePageObject = StagesPageObject(tester);

      await tester.pumpEditor();
      await EditorPageObject(tester).openStageTab();

      // Creates a stage first
      await stagePageObject.createStage('game');
      await stagePageObject.createStage('title');

      await tester.tap(find.sideBarItemWithText('game'));
      await tester.pumpAndSettle();

      // A tab should have open, with it selected
      expect(
        find.byTabOptions(label: 'game', selected: true),
        findsOneWidget,
      );

      await tester.tap(find.sideBarItemWithText('title'));
      await tester.pumpAndSettle();

      // A tab should have open, with it selected and the previous should exists still
      // but not selected
      expect(
        find.byTabOptions(label: 'title', selected: true),
        findsOneWidget,
      );
      expect(
        find.byTabOptions(label: 'game', selected: false),
        findsOneWidget,
      );
    });
  });
}
