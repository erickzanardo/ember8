import 'package:console/theme.dart';
import 'package:flutter/material.dart';

class DPad extends StatelessWidget {
  final double size;

  const DPad({
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DirectionalButton(
            size: size,
            direction: Direction.top,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: DirectionalButton(
                  size: size,
                  direction: Direction.left,
                ),
              ),
              Expanded(
                child: DirectionalButton(
                  size: size,
                  direction: Direction.right,
                ),
              ),
            ],
          ),
          DirectionalButton(
            size: size,
            direction: Direction.bottom,
          ),
        ],
      ),
    );
  }
}

enum Direction {
  top,
  bottom,
  right,
  left,
}

class DirectionalButton extends StatefulWidget {
  final double size;
  final Direction direction;

  const DirectionalButton({
    required this.size,
    required this.direction,
  });

  @override
  State<DirectionalButton> createState() => _DirectionalButtonState();
}

class _DirectionalButtonState extends State<DirectionalButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _pressed = true);
        print('TAP DOWN ${widget.direction}');
      },
      onTapUp: (_) {
        setState(() => _pressed = false);
        print('TAP UP ${widget.direction}');
      },
      onTapCancel: () {
        setState(() => _pressed = false);
      },
      child: Container(
        decoration: BoxDecoration(
          color: ConsoleTheme.of(context).dPadColor,
        ),
        child: UnconstrainedBox(
          alignment: widget.direction == Direction.right
              ? Alignment.centerRight
              : widget.direction == Direction.left
                  ? Alignment.centerLeft
                  : Alignment.center,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              border: widget.direction != Direction.top
                  ? Border(
                      bottom: BorderSide(
                        color: ConsoleTheme.of(context).dPadBorderColor,
                        width: _pressed
                            ? ConsoleTheme.of(context).dPadBorderSize / 2
                            : ConsoleTheme.of(context).dPadBorderSize,
                      ),
                    )
                  : null,
            ),
            child: Container(
              padding: _pressed
                  ? EdgeInsets.only(
                      top: ConsoleTheme.of(context).dPadBorderSize / 2)
                  : null,
              child: RotatedBox(
                quarterTurns: _calculateTransform(widget.direction),
                child: Align(
                  alignment: _calculateAlignment(widget.direction),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ClipPath(
                      clipper: TriangleClipper(),
                      child: Container(
                        color: ConsoleTheme.of(context).dPadButtonColor,
                        height: widget.size / 3,
                        width: widget.size,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Alignment _calculateAlignment(Direction direction) {
    switch (direction) {
      case Direction.top:
        return Alignment.bottomCenter;
      case Direction.bottom:
        return Alignment.bottomCenter;
      case Direction.right:
        return Alignment.bottomRight;
      case Direction.left:
        return Alignment.bottomLeft;
    }
  }

  int _calculateTransform(Direction direction) {
    switch (direction) {
      case Direction.top:
        return 2;
      case Direction.bottom:
        return 0;
      case Direction.right:
        return 3;
      case Direction.left:
        return 1;
    }
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
