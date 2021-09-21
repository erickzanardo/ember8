import 'package:editor/src/project/models/project.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'project_events.dart';
import 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    ProjectState initialState = const ProjectState(),
  }) : super(initialState) {
    on<NewScriptEvent>(_handleNewScript);
    on<UpdateScriptEvent>(_handleUpdateScript);
    on<NewSpriteEvent>(_handleNewSprite);
    on<PaintSpritePixelEvent>(_handlePaintSpritePixel);
    on<NewTemplateEvent>(_handleNewTemplate);
    on<AddFieldTemplateEvent>(_handleAddFieldTemplate);
    on<UpdateFieldTemplateEvent>(_handleUpdateFielTemplate);
    on<RemoveFieldTemplateEvent>(_handleRemoveFieldTemplate);
    on<NewStageEvent>(_handleNewStage);
  }

  Future<void> _handleNewScript(
    NewScriptEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(
      state.copyWith(
        project: Project(
          scripts: [
            ...state.project?.scripts ?? [],
            ProjectScript(
              type: event.type,
              name: event.name,
              body: '',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleUpdateScript(
    UpdateScriptEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(
      state.copyWith(
        project: Project(
          scripts: state.project?.scripts.map((script) {
            if (script.name == event.name) {
              return script.copyWithNewBody(event.code);
            } else {
              return script;
            }
          }).toList() ?? [],
        ),
      ),
    );
  }

  Future<void> _handleNewSprite(
      NewSpriteEvent event, Emitter<ProjectState> emit) async {
    final pixels = List.generate(event.height, (index) {
      return List.filled(event.width, null, growable: false);
    }, growable: false);

    emit(
      state.copyWith(
        project: Project(
          sprites: [
            ...state.project?.sprites ?? [],
            ProjectSprite(
              name: event.name,
              pixels: pixels,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePaintSpritePixel(
    PaintSpritePixelEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(
      state.copyWith(
        project: Project(
          sprites: [
            ...state.project?.sprites.map((sprite) {
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
            }).toList() ?? [],
          ],
        ),
      ),
    );
  }

  Future<void> _handleNewTemplate(
    NewTemplateEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(
      state.copyWith(
        project: Project(
          templates: [
            ...state.project?.templates ?? [],
            ProjectTemplate(event.name, const []),
          ],
        ),
      ),
    );
  }

  Future<void> _handleAddFieldTemplate(
    AddFieldTemplateEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(
      state.copyWith(
        project: Project(
          templates: state.project?.templates.map((template) {
            if (template.name == event.templateName) {
              return template.copyWithNewField(event.toProjectTemplateField());
            } else {
              return template;
            }
          }).toList() ?? [],
        ),
      ),
    );
  }

  Future<void> _handleUpdateFielTemplate(
    UpdateFieldTemplateEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(
      state.copyWith(
        project: Project(
          templates: state.project?.templates.map((template) {
            if (template.name == event.templateName) {
              return ProjectTemplate(
                template.name,
                template.fields.map(
                  (field) {
                    if (field.name == event.fieldName) {
                      return event.toProjectTemplateField();
                    } else {
                      return field;
                    }
                  },
                ).toList(),
              );
            } else {
              return template;
            }
          }).toList() ?? [],
        ),
      ),
    );
  }

  Future<void> _handleRemoveFieldTemplate(
    RemoveFieldTemplateEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(
      state.copyWith(
        project: Project(
          templates: state.project?.templates.map((template) {
            if (template.name == event.templateName) {
              return ProjectTemplate(
                template.name,
                template.fields
                    .where((element) => element.name != event.fieldName)
                    .toList(),
              );
            } else {
              return template;
            }
          }).toList() ?? [],
        ),
      ),
    );
  }

  Future<void> _handleNewStage(
    NewStageEvent event,
    Emitter<ProjectState> emit,
  ) async {
    emit(
      state.copyWith(
        project: Project(
          stages: [
            ...state.project?.stages ?? [],
            ProjectStage(event.name, const []),
          ],
        ),
      ),
    );
  }
}
