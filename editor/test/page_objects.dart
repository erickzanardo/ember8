import 'package:editor/src/editor/widgets/editor_scaffold.dart';
import 'package:editor/src/editor/widgets/scripts/scripts_workspace.dart';
import 'package:editor/src/editor/widgets/sprites/sprites_workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class PageObject {
  final WidgetTester tester;

  PageObject(this.tester);
}

class EditorPageObject extends PageObject {
  EditorPageObject(WidgetTester tester) : super(tester);

  Future<void> openSpriteTab() async {
    await tester.tap(find.text('Sprites'));
    await tester.pumpAndSettle();
  }
}

class ScriptsPageObject extends PageObject {
  ScriptsPageObject(WidgetTester tester) : super(tester);

  Future<void> openScriptCreationForm() async {
    await tester.tap(find.byKey(ScriptsWorkspace.newScriptKey));
    await tester.pumpAndSettle();
  }

  Future<void> fillNewScriptName(String name) async {
    await tester.enterText(find.byType(TextField), name);
  }

  Future<void> cancelScriptForm() async {
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
  }

  Future<void> createScript(String name, String type) async {
    await openScriptCreationForm();

    await fillNewScriptName(name);

    await tester.tap(find.text('Controller'));
    await tester.pumpAndSettle();

    await tester.tap(find.text(type).last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
  }
}

class SpritesPageObject extends PageObject {
  SpritesPageObject(WidgetTester tester) : super(tester);

  Future<void> openSpritesCreationForm() async {
    await tester.tap(find.byKey(SpritesWorkspace.newSpriteKey));
    await tester.pumpAndSettle();
  }

  Future<void> createSprite(String name, int width, int height) async {
    await openSpritesCreationForm();

    await tester.enterText(find.byType(TextField).at(0), name);
    await tester.enterText(find.byType(TextField).at(1), width.toString());
    await tester.enterText(find.byType(TextField).at(2), height.toString());

    await tester.tap(find.text('Create'));
    await tester.pumpAndSettle();
  }
}
