import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../page_objects.dart';
import '../../../widgets_extensions.dart';

void main() {
  group('Widgets - Editor - Templates', () {
    testWidgets('it adds a template', (tester) async {
      await tester.pumpWithCreatedProject();

      await EditorPageObject(tester).openTemplateTab();

      // No templates should exists
      expect(find.text('Empty'), findsOneWidget);

      final templatePageObject = TemplatesPageObject(tester);
      await templatePageObject.openTemplatesCreationForm();

      await tester.enterText(find.byType(TextField), 'bullet');

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(
          find.byTabOptions(label: 'bullet', selected: true), findsOneWidget);
      expect(find.sideBarItemWithText('bullet'), findsOneWidget);
      expect(find.text('Empty'), findsNothing);
    });

    testWidgets('it can cancel the new template', (tester) async {
      await tester.pumpWithCreatedProject();

      await EditorPageObject(tester).openTemplateTab();

      // No templates should exists
      expect(find.text('Empty'), findsOneWidget);

      final templatePageObject = TemplatesPageObject(tester);
      await templatePageObject.openTemplatesCreationForm();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.text('Empty'), findsOneWidget);
    });

    testWidgets('it can open template from the sidebar', (tester) async {
      final templatePageObject = TemplatesPageObject(tester);

      await tester.pumpWithCreatedProject();
      await EditorPageObject(tester).openTemplateTab();

      // Creates a template first
      await templatePageObject.createTemplate('bullet');
      await templatePageObject.createTemplate('enemy');

      await tester.tap(find.sideBarItemWithText('bullet'));
      await tester.pumpAndSettle();

      // A tab should have open, with it selected
      expect(
        find.byTabOptions(label: 'bullet', selected: true),
        findsOneWidget,
      );

      await tester.tap(find.sideBarItemWithText('enemy'));
      await tester.pumpAndSettle();

      // A tab should have open, with it selected and the previous should exists still
      // but not selected
      expect(
        find.byTabOptions(label: 'enemy', selected: true),
        findsOneWidget,
      );
      expect(
        find.byTabOptions(label: 'bullet', selected: false),
        findsOneWidget,
      );
    });
  });
}
