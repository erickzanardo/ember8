part of 'templates_bloc.dart';

abstract class TemplatesEvent extends Equatable {
  const TemplatesEvent();
}

class NewTemplateEvent extends TemplatesEvent {
  final String projectId;
  final String name;

  const NewTemplateEvent({
    required this.projectId,
    required this.name,
  });

  @override
  List<Object?> get props => [projectId, name];
}

abstract class ManageFieldTemplateEvent<T> extends TemplatesEvent {
  final String templateId;
  final String fieldName;
  final T value;

  const ManageFieldTemplateEvent({
    required this.templateId,
    required this.fieldName,
    required this.value,
  });

  @override
  List<Object?> get props => [templateId, fieldName, value];
}

class AddFieldTemplateEvent<T> extends ManageFieldTemplateEvent<T> {
  const AddFieldTemplateEvent({
    required String templateId,
    required String fieldName,
    required T value,
  }) : super(
          templateId: templateId,
          fieldName: fieldName,
          value: value,
        );
}

class UpdateFieldTemplateEvent<T> extends ManageFieldTemplateEvent<T> {
  const UpdateFieldTemplateEvent({
    required String templateId,
    required String fieldName,
    required T value,
  }) : super(
          templateId: templateId,
          fieldName: fieldName,
          value: value,
        );
}

class RemoveFieldTemplateEvent extends TemplatesEvent {
  final String templateId;
  final String fieldName;

  const RemoveFieldTemplateEvent({
    required this.templateId,
    required this.fieldName,
  });

  @override
  List<Object?> get props => [templateId, fieldName];
}
