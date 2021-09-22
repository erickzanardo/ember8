import 'package:editor/src/editor/widgets/sprites/sprite_editor/sprite_editor_cell.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../page_objects.dart';
import '../../../widgets_extensions.dart';

void main() {
  group('Widgets - Editor - Sprites Pixel Editor', () {
    testWidgets('can paint a pixel using the brush and remove with the eraser',
        (tester) async {
      final spritePageObject = SpritesPageObject(tester);

      await tester.pumpWithCreatedProject();
      await EditorPageObject(tester).openSpriteTab();

      // Creates a sprite first
      await spritePageObject.createSprite('playerSprite', 2, 2);

      // Brush is the default tool, so no need to select it
      await spritePageObject.selectColorInPalette(0);
      await spritePageObject.paintPixel(0);

      expect(
        find.byWidgetPredicate((widget) {
          return widget is SpriteEditorCell && widget.color == 0;
        }),
        findsOneWidget,
      );

      await tester.tap(find.byIconButtonTooltip('Eraser'));
      await tester.pumpAndSettle();

      await spritePageObject.paintPixel(0);

      expect(
        find.byWidgetPredicate((widget) {
          return widget is SpriteEditorCell && widget.color == null;
        }),
        findsNWidgets(4),
      );

      await tester.tap(find.byIconButtonTooltip('Brush'));
      await tester.pumpAndSettle();

      await spritePageObject.paintPixel(0);

      expect(
        find.byWidgetPredicate((widget) {
          return widget is SpriteEditorCell && widget.color == 0;
        }),
        findsOneWidget,
      );
    });
  });
}
