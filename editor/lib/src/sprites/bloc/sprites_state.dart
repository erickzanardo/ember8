part of 'sprites_bloc.dart';

class SpritesState extends Equatable {
  const SpritesState({
    required this.sprites,
  });
  
  const SpritesState.initial() : this(sprites: const []);

  final List<ProjectSprite> sprites;

  @override
  List<Object> get props => [sprites];

  SpritesState copyWith({
    List<ProjectSprite>? sprites,
  }) {
    return SpritesState(sprites: sprites ?? this.sprites);
  }
}
