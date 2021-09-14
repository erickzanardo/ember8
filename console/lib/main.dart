import 'package:console/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ConsoleTheme(child: ConsoleApp()));
}

class ConsoleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ember8',
      home: Scaffold(
        body: Center(
          child: Text('Hi!'),
        ),
      ),
    );
  }
}
