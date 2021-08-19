import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../page_objects.dart';
import '../../widgets_extensions.dart';

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
  });
}
