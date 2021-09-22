import 'package:editor/src/project/project.dart';
import 'package:editor/src/widgets/icon_button.dart';
import 'package:editor/src/widgets/side_bar_item.dart';
import 'package:editor/src/widgets/tab.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_test/flutter_test.dart';

extension EditorWidgetTester on WidgetTester {
  Future<void> pumpWithCreatedProject(
      {String projectName = 'cool game'}) async {
    await pumpWidget(const Project());

    await tap(find.text('New project'));
    await pumpAndSettle();

    await enterText(find.byType(material.TextField), projectName);
    await tap(find.text('Create'));
    await pumpAndSettle();
  }
}

extension EditorCommonFinders on CommonFinders {
  Finder byTabOptions({
    required String label,
    bool selected = false,
  }) {
    return byWidgetPredicate((widget) {
      return widget is Tab &&
          widget.selected == selected &&
          widget.label == label;
    });
  }

  Finder closeIconFromTabOptions({
    required String label,
    bool selected = false,
  }) {
    final tab = byWidgetPredicate((widget) {
      return widget is Tab &&
          widget.selected == selected &&
          widget.label == label;
    });

    return descendant(of: tab, matching: byType(IconButton));
  }

  Finder byIconButtonTooltip(String tooltip) {
    return byWidgetPredicate((widget) {
      return widget is IconButton && widget.tooltip == tooltip;
    });
  }

  Finder sideBarItemWithText(String label) {
    return descendant(of: byType(SideBarItem), matching: text(label));
  }
}
