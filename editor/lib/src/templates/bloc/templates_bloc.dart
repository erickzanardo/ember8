import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repository/repository.dart';

part 'templates_event.dart';
part 'templates_state.dart';

class TemplatesBloc extends Bloc<TemplatesEvent, TemplatesState> {
  TemplatesBloc() : super(const TemplatesState.initial()) {
    on<NewTemplateEvent>(_handleNewTemplate);
    on<AddFieldTemplateEvent>(_handleAddFieldTemplate);
    on<UpdateFieldTemplateEvent>(_handleUpdateFielTemplate);
    on<RemoveFieldTemplateEvent>(_handleRemoveFieldTemplate);
  }

  Future<void> _handleNewTemplate(
    NewTemplateEvent event,
    Emitter<TemplatesState> emit,
  ) async {
    emit(
      state.copyWith(
        templates: [
          ...state.templates,
          ProjectTemplate(projectId: event.projectId, name: event.name),
        ],
      ),
    );
  }

  Future<void> _handleAddFieldTemplate(
    AddFieldTemplateEvent event,
    Emitter<TemplatesState> emit,
  ) async {
    emit(
      state.copyWith(
        fields: [
          ...state.fields,
          ProjectTemplateField(
              templateId: event.templateId,
              name: event.fieldName,
              value: event.value),
        ],
      ),
    );
  }

  Future<void> _handleUpdateFielTemplate(
    UpdateFieldTemplateEvent event,
    Emitter<TemplatesState> emit,
  ) async {
    emit(
      state.copyWith(
        fields: state.fields.map(
          (field) {
            if (field.name == event.fieldName) {
              return ProjectTemplateField(
                  templateId: field.templateId,
                  name: field.name,
                  value: event.value);
            } else {
              return field;
            }
          },
        ).toList(),
      ),
    );
  }

  Future<void> _handleRemoveFieldTemplate(
    RemoveFieldTemplateEvent event,
    Emitter<TemplatesState> emit,
  ) async {
    emit(
      state.copyWith(
        fields: state.fields
            .where(
              (element) => element.name != event.fieldName,
            )
            .toList(),
      ),
    );
  }
}
