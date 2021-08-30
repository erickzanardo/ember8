import 'package:flutter_bloc/flutter_bloc.dart';

import 'project_events.dart';
import 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    ProjectState initialState = const ProjectState(),
  }) : super(initialState);

  @override
  Stream<ProjectState> mapEventToState(ProjectEvent event) async* {
    if (event is NewScriptEvent) {
      yield state.copyWith(
        scripts: [
          ...state.scripts,
          ProjectScript(
            type: event.type,
            name: event.name,
            body: '',
          ),
        ],
      );
    } else if (event is UpdateScriptEvent) {
      yield state.copyWith(
        scripts: state.scripts.map((script) {
          if (script.name == event.name) {
            return script.copyWithNewBody(event.code);
          } else {
            return script;
          }
        }).toList(),
      );
    } else if (event is NewSpriteEvent) {
      final pixels = List.generate(event.height, (index) {
        return List.filled(event.width, null, growable: false);
      }, growable: false);

      yield state.copyWith(
        sprites: [
          ...state.sprites,
          ProjectSprite(
            name: event.name,
            pixels: pixels,
          ),
        ],
      );
    } else if (event is PaintSpritePixelEvent) {
      yield state.copyWith(
        sprites: [
          ...state.sprites.map((sprite) {
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

              return sprite.copyWithNewPixels(newPixels);
            } else {
              return sprite;
            }
          }).toList(),
        ],
      );
    } else if (event is NewTemplateEvent) {
      yield state.copyWith(
        templates: [
          ...state.templates,
          ProjectTemplate(event.name, const []),
        ],
      );
    } else if (event is AddFieldTemplateEvent) {
      yield state.copyWith(
        templates: state.templates.map((template) {
          if (template.name == event.templateName) {
            return template.copyWithNewField(event.toProjectTemplateField());
          } else {
            return template;
          }
        }).toList(),
      );
    } else if (event is UpdateFieldTemplateEvent) {
      yield state.copyWith(
        templates: state.templates.map((template) {
          if (template.name == event.templateName) {
            return ProjectTemplate(
                template.name,
                template.fields.map((field) {
                  if (field.name == event.fieldName) {
                    return event.toProjectTemplateField();
                  } else {
                    return field;
                  }
                }).toList(),
            );
          } else {
            return template;
          }
        }).toList(),
      );
    } else if (event is RemoveFieldTemplateEvent) {
      yield state.copyWith(
        templates: state.templates.map((template) {
          if (template.name == event.templateName) {
            return ProjectTemplate(
                template.name,
                template.fields.where((element) => element.name != event.fieldName).toList(),
            );
          } else {
            return template;
          }
        }).toList(),
      );
    } else if (event is NewStageEvent) {
      yield state.copyWith(
        stages: [
          ...state.stages,
          ProjectStage(event.name, const []),
        ],
      );
    }
  }
}
