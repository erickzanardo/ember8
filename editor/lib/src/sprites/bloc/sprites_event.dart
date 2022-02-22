part of 'sprites_bloc.dart';

abstract class SpritesEvent extends Equatable {
  const SpritesEvent();
}

class NewSpriteEvent extends SpritesEvent {
  final String projectId;
  final String name;
  final int width;
  final int height;

  const NewSpriteEvent({
    required this.projectId,
    required this.name,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [projectId, name, width, height];
}

class PaintSpritePixelEvent extends SpritesEvent {
  final String spriteName;
  final int x;
  final int y;
  final int? color;

  const PaintSpritePixelEvent({
    required this.spriteName,
    required this.x,
    required this.y,
    required this.color,
  });

  @override
  List<Object?> get props => [spriteName, x, y, color];
}

