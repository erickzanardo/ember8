import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../page_objects.dart';
import '../../../widgets_extensions.dart';

void main() {
  group('Widgets - Editor - Sprites', () {
    testWidgets('it adds a controller sprite (the default one)',
        (tester) async {
      await tester.pumpEditor();

      await EditorPageObject(tester).openSpriteTab();

      // No sprites should exists
      expect(find.text('Empty'), findsOneWidget);

      final spritePageObject = SpritesPageObject(tester);
      await spritePageObject.openSpritesCreationForm();

      await tester.enterText(find.byType(TextField).at(0), 'playerSprite');
      await tester.enterText(find.byType(TextField).at(1), '10');
      await tester.enterText(find.byType(TextField).at(2), '10');

      await tester.tap(find.text('Create'));
      await tester.pumpAndSettle();

      expect(find.text('playerSprite'), findsOneWidget);
      expect(find.text('Empty'), findsNothing);
    });

    testWidgets('it can cancel the new sprite',
        (tester) async {
      await tester.pumpEditor();

      await EditorPageObject(tester).openSpriteTab();

      // No sprites should exists
      expect(find.text('Empty'), findsOneWidget);

      final spritePageObject = SpritesPageObject(tester);
      await spritePageObject.openSpritesCreationForm();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.text('Empty'), findsOneWidget);
    });

    testWidgets('it can open sprite from the sidebar', (tester) async {
      final spritePageObject = SpritesPageObject(tester);

      await tester.pumpEditor();
      await EditorPageObject(tester).openSpriteTab();

      // Creates a sprite first
      await spritePageObject.createSprite('playerSprite', 10, 10);
      await spritePageObject.createSprite('playerAttack', 10, 10);

      await tester.tap(find.text('playerSprite'));
      await tester.pumpAndSettle();

      // A tab should have open, with it selected
      expect(
        find.byTabOptions(label: 'playerSprite', selected: true),
        findsOneWidget,
      );

      await tester.tap(find.text('playerAttack'));
      await tester.pumpAndSettle();

      // A tab should have open, with it selected and the previous should exists still
      // but not selected
      expect(
        find.byTabOptions(label: 'playerAttack', selected: true),
        findsOneWidget,
      );
      expect(
        find.byTabOptions(label: 'playerSprite', selected: false),
        findsOneWidget,
      );
    });
  });
}
