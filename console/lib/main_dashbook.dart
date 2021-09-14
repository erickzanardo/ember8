import 'package:console/theme.dart';
import 'package:console/widgets/dpad.dart';
import 'package:flutter/material.dart';

import 'package:dashbook/dashbook.dart';

void main() {
  final dashbook = Dashbook(
    usePreviewSafeArea: true,
  );

  dashbook.storiesOf('dpad').decorator(CenterDecorator()).add(
    'default',
    (ctx) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DPad(
            size: 75,
          ),
        ],
      );
    },
  );

  runApp(ConsoleTheme(child: dashbook));
}
