import 'package:console/widgets/dpad.dart';
import 'package:flutter/material.dart';

import 'package:dashbook/dashbook.dart';

void main() {
  final dashbook = Dashbook();

  dashbook.storiesOf('dpad').decorator(CenterDecorator()).add(
    'default',
    (ctx) {
      return DPad();
    },
  );

  runApp(dashbook);
}
