import 'package:flutter/material.dart';

class ConsoleThemeData {
  final Color dPadColor;
  final Color dPadButtonColor;
  final Color dPadBorderColor;

  final double dPadBorderSize;

  const ConsoleThemeData({
    this.dPadColor = const Color(0xff414141),
    this.dPadButtonColor = const Color(0xffc4c4c4),
    this.dPadBorderColor = const Color(0xff151515),
    this.dPadBorderSize = 8,
  });
}

class ConsoleTheme extends InheritedWidget {
  final ConsoleThemeData theme;

  const ConsoleTheme({
    required Widget child,
    this.theme = const ConsoleThemeData(),
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static ConsoleThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<ConsoleTheme>();
    assert(widget != null, 'No ConsoleTheme available on the tree');

    return widget!.theme;
  }
}
