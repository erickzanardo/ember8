import 'package:console/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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

class DirectionalButton extends StatelessWidget {
  final double size;
  final Direction direction;

  const DirectionalButton({
    required this.size,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('DIRECTION $direction'),
      child: Container(
        decoration: BoxDecoration(
          color: ConsoleTheme.of(context).dPadColor,
        ),
        child: UnconstrainedBox(
          alignment: direction == Direction.right
              ? Alignment.centerRight
              : direction == Direction.left
                  ? Alignment.centerLeft
                  : Alignment.center,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              border: direction != Direction.top
                  ? Border(
                      bottom: BorderSide(
                        color: ConsoleTheme.of(context).dPadBorderColor,
                        width: ConsoleTheme.of(context).dPadBorderSize,
                      ),
                    )
                  : null,
            ),
            child: RotatedBox(
              quarterTurns: _calculateTransform(direction),
              child: Align(
                alignment: _calculateAlignment(direction),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: ClipPath(
                    clipper: TriangleClipper(),
                    child: Container(
                      color: ConsoleTheme.of(context).dPadButtonColor,
                      height: size / 3,
                      width: size,
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
