import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';

part 'sprites_event.dart';
part 'sprites_state.dart';

class SpritesBloc extends Bloc<SpritesEvent, SpritesState> {
  SpritesBloc() : super(const SpritesState.initial()) {
    on<NewSpriteEvent>(_handleNewSprite);
    on<PaintSpritePixelEvent>(_handlePaintSpritePixel);
  }

  Future<void> _handleNewSprite(
      NewSpriteEvent event, Emitter<SpritesState> emit) async {
    final pixels = List.generate(event.height, (index) {
      return List.filled(event.width, null, growable: false);
    }, growable: false);

    emit(
      state.copyWith(
        sprites: [
          ...state.sprites,
          ProjectSprite(
            projectId: event.projectId,
            name: event.name,
            pixels: pixels,
          ),
        ],
      ),
    );
  }

  Future<void> _handlePaintSpritePixel(
    PaintSpritePixelEvent event,
    Emitter<SpritesState> emit,
  ) async {
    emit(
      state.copyWith(
        sprites: [
          ...state.sprites.map(
            (sprite) {
              if (sprite.name == event.spriteName) {
                final newPixels = List.generate(sprite.pixels.length, (y) {
                  return List.generate(sprite.pixels[y].length, (x) {
                    if (y == event.y && x == event.x) {
                      return event.color;
                    } else {
                      return sprite.pixels[y][x];
                    }
                  });
                });

                return sprite.copyWith(pixels: newPixels);
              } else {
                return sprite;
              }
            },
          ).toList(),
        ],
      ),
    );
  }
}
