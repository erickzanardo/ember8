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
        'd': 0,
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

        obj['x'] = x + (40 * dt * d)
      ''',
      ),
      EmberDpadScript(
          name: 'playerMovement',
          body: '''
          let player = get_obj('player')
          if (key == 'left' && type == 'down') {
            player['d'] = -1
          }
          if (key == 'right' && type == 'down') {
            player['d'] = 1
          }
          if (key == 'left' && type == 'up' && player['d'] == -1) {
            player['d'] = 0
          }
          if (key == 'right' && type == 'up' && player['d'] == 1) {
            player['d'] = 0
          }
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
  }

  KeyEventResult _keyboardEvent(FocusNode node, RawKeyEvent event) {
    final buttonEvent =
        event is RawKeyDownEvent ? ButtonEvent.down : ButtonEvent.up;

    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      game.sendDpadEvent(DpadEvent.left, buttonEvent);
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      game.sendDpadEvent(DpadEvent.right, buttonEvent);
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      game.sendDpadEvent(DpadEvent.top, buttonEvent);
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      game.sendDpadEvent(DpadEvent.bottom, buttonEvent);
    }

    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Focus(
          autofocus: true,
          onKey: _keyboardEvent,
          child: GameWidget(
            game: game,
          ),
        ),
      ),
    );
  }
}
