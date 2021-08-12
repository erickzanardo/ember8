import 'package:engine/engine.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  final cartridge = EmberCartridge(
    sprites: [
      EmberSprite(
        'ship',
        [
          [null, null, 4, 4, 4, null, null],
          [null, null, 4, 4, 4, null, null],
          [null, null, 4, 4, 4, null, null],
          [null, null, 4, 4, 4, null, null],
          [null, null, 4, 4, 4, null, null],
          [null, null, 4, 4, 4, null, null],
          [null,    6, 4, 4, 4, 6   , null],
          [null,    6, 4, 4, 4, 6   , null],
          [   5,    6, 4, 4, 4, 6   , 5   ],
          [   5,    6, 4, 4, 4, 6   , 5   ],
          [   5,    6, 4, 4, 4, 6   , 5   ],
          [   5,    6, 4, 4, 4, 6   , 5   ],
        ],
      ),
      EmberSprite(
        'bullet',
        [
          [7, 7],
          [7, 7],
          [7, 7],
          [7, 7],
        ],
      ),
    ],
    objects: {
      'player': {
        'x': 80.0,
        'y': 120.0,
        'dx': 0.0,
        'dy': 0.0,
        'sprite': 'ship',
        'script': 'playerController',
      },
    },
    templates: {
      'bullet': {
        'script': 'bulletController',
        'sprite': 'bullet',
      },
    },
    scripts: [
      EmberControllerScript(
        name: 'playerController',
        body: '''
        let x = obj['x']
        let y = obj['y']
        let w = obj['w'] 
        let dx = obj['dx']
        let dy = obj['dy']

        obj['x'] = x + (40 * dt * dx)
        obj['y'] = y + (40 * dt * dy)
      ''',
      ),
      EmberControllerScript(
        name: 'bulletController',
        body: '''
        let y = obj['y']
        let h = obj['h']

        obj['y'] = y - (80 * dt)

        if (y + h < 0) {
          remove_obj(objId)
        }

      ''',
      ),
      EmberDpadScript(
          name: 'playerMovementHandler',
          body: '''
          let player = get_obj('player')
          if (key == 'left' && type == 'down') {
            player['dx'] = -1
          }
          if (key == 'right' && type == 'down') {
            player['dx'] = 1
          }
          if (key == 'left' && type == 'up' && player['dx'] == -1) {
            player['dx'] = 0
          }
          if (key == 'right' && type == 'up' && player['dx'] == 1) {
            player['dx'] = 0
          }
          if (key == 'bottom' && type == 'down') {
            player['dy'] = 1
          }
          if (key == 'top' && type == 'down') {
            player['dy'] = -1
          }
          if (key == 'bottom' && type == 'up' && player['dy'] == 1) {
            player['dy'] = 0
          }
          if (key == 'top' && type == 'up' && player['dy'] == -1) {
            player['dy'] = 0
          }
          '''
      ),
      EmberActionScript(
          name: 'playerActionHandler',
          body: '''
          if (key == 'a' && type == 'down') {
            let player = get_obj('player');
            let x = player['x'] + 3;
            let y = player['y'];
            create_anonymous_obj('bullet', {'x': x, 'y': y })
          }
          ''',
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
    } else if (event.logicalKey == LogicalKeyboardKey.keyK) {
      game.sendActionEvent(ActionEvent.a, buttonEvent);
    } else if (event.logicalKey == LogicalKeyboardKey.keyL) {
      game.sendActionEvent(ActionEvent.b, buttonEvent);
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
