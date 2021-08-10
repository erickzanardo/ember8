import 'package:engine/engine.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  final cartridge = EmberCartridge(
    sprites: [
      EmberSprite(
        'pad',
        [
          [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
          [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
          [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
          [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
        ],
      ),
    ],
    objects: {
      'player': {
        'x': 10.0,
        'y': 138.0,
        'd': 1,
        'sprite': 'pad',
        'script': 'playerController',
      },
    },
    scripts: [
      EmberControllerScript(
        name: 'playerController',
        body: '''
        let x = obj['x']
        let w = obj['w'] 
        let d = obj['d']

        if ((x + w >= SCREEN_WIDTH && d > 0)) {
          obj['d'] = -1
        }

        if ((x < 0 && d < 0)) {
          obj['d'] = 1
        }

        obj['x'] = x + (40 * dt * d)
      ''',
      ),
      EmberDpadScript(
          name: 'playerMovement',
          body: '''
            print(key)
            print(type)
          '''
      ),
    ],
  );

  runApp(MyApp(cartridge: cartridge));
}

class MyApp extends StatefulWidget {
  final EmberCartridge cartridge;

  const MyApp({
    required this.cartridge,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late EmberGame game;

  @override
  void initState() {
    super.initState();

    game = EmberGame(widget.cartridge);

    RawKeyboard.instance.addListener(_keyboardEvent);
  }

  void _keyboardEvent(RawKeyEvent event) {
    final buttonEvent =
        event is RawKeyDownEvent ? ButtonEvent.down : ButtonEvent.up;

    if (event.character == 'a') {
      game.sendDpadEvent(DpadEvent.left, buttonEvent);
    } else if (event.character == 'd') {
      game.sendDpadEvent(DpadEvent.right, buttonEvent);
    } else if (event.character == 'w') {
      game.sendDpadEvent(DpadEvent.top, buttonEvent);
    } else if (event.character == 's') {
      game.sendDpadEvent(DpadEvent.bottom, buttonEvent);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: GameWidget(
          game: game,
        ),
      ),
    );
  }
}
