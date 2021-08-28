
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../page_objects.dart';
import '../../../widgets_extensions.dart';

void main() {
  group('Widgets - Editor - Template Editor', () {
    testWidgets('can add string fields', (tester) async {
      await tester.pumpEditor();
      await EditorPageObject(tester).openTemplateTab();

      final templatePageObject = TemplatesPageObject(tester);
      await templatePageObject.createTemplate('Bullet');

      await tester.tap(find.byIconButtonTooltip('New field'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'sprite');
      await tester.tap(find.text('Create'));

      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('can add boolean fields', (tester) async {
      await tester.pumpEditor();
      await EditorPageObject(tester).openTemplateTab();

      final templatePageObject = TemplatesPageObject(tester);
      await templatePageObject.createTemplate('Bullet');

      await tester.tap(find.byIconButtonTooltip('New field'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'active');
      await tester.tap(find.text('String'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Boolean').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('can add number fields', (tester) async {
      await tester.pumpEditor();
      await EditorPageObject(tester).openTemplateTab();

      final templatePageObject = TemplatesPageObject(tester);
      await templatePageObject.createTemplate('Bullet');

      await tester.tap(find.byIconButtonTooltip('New field'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'active');
      await tester.tap(find.text('String'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Number (double)').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsOneWidget);
    });
  });
}
