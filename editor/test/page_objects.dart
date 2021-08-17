import 'package:editor/src/editor/widgets/scripts/scripts_workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

abstract class PageObject {
  final WidgetTester tester;

  PageObject(this.tester);
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
