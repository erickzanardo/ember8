import 'package:editor/src/editor/editor.dart';
import 'package:editor/src/widgets/icon_button.dart';
import 'package:editor/src/widgets/tab.dart';
import 'package:flutter_test/flutter_test.dart';

extension EditorWidgetTester on WidgetTester {

  Future<void> pumpEditor() =>
      pumpWidget(const Editor());
}

extension EditorCommonFinders on CommonFinders {
  Finder byTabOptions({
    required String label,
    bool selected = false,
  }) {
    return byWidgetPredicate((widget) {
      return widget is Tab && widget.selected == selected && widget.label == label;
    });
  }

  Finder closeIconFromTabOptions({
    required String label,
    bool selected = false,
  }) {
    final tab = byWidgetPredicate((widget) {
      return widget is Tab && widget.selected == selected && widget.label == label;
    });

    return descendant(of: tab, matching: byType(IconButton));
  }
}

