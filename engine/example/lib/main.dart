import 'package:engine/engine.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final cartridge = EmberCartridge(
    sprites: [
      EmberSprite(
        'pad',
        [
          [4, 4, 4, 4, 4, 4, 4]
        ],
      ),
    ],
    objects: {
      'player': {
        'x': 10.0,
        'y': 142.0,
        'sprite': 'pad',
      },
    },
  );

  runApp(MyApp(cartridge: cartridge));
}

class MyApp extends StatelessWidget {
  final EmberCartridge cartridge;

  const MyApp({
    required this.cartridge,
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: GameWidget(
          game: EmberGame(cartridge),
        ),
      ),
    );
  }
}
