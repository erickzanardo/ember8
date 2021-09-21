import 'package:editor/src/project/models/project.dart';
import 'package:equatable/equatable.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();
}

class NewScriptEvent extends ProjectEvent {
  final String name;
  final ProjectScriptType type;

  const NewScriptEvent(this.name, this.type);

  @override
  List<Object?> get props => [name, type];
}

class UpdateScriptEvent extends ProjectEvent {
  final String name;
  final String code;

  const UpdateScriptEvent(this.name, this.code);

  @override
  List<Object?> get props => [name, code];
}

class NewSpriteEvent extends ProjectEvent {
  final String name;
  final int width;
  final int height;

  const NewSpriteEvent({
    required this.name,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [name, width, height];
}

class PaintSpritePixelEvent extends ProjectEvent {
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

class NewTemplateEvent extends ProjectEvent {
  final String name;

  const NewTemplateEvent(this.name);

  @override
  List<Object?> get props => [name];
}

abstract class ManageFieldTemplateEvent<T> extends ProjectEvent {
  final String templateName;
  final String fieldName;
  final T value;

  const ManageFieldTemplateEvent(this.templateName, this.fieldName, this.value);

  @override
  List<Object?> get props => [templateName, fieldName, value];

  ProjectTemplateField<T> toProjectTemplateField() {
    return ProjectTemplateField<T>(
      fieldName,
      value,
    );
  }
}

class AddFieldTemplateEvent<T> extends ManageFieldTemplateEvent<T> {
  const AddFieldTemplateEvent(String templateName, String fieldName, T value)
      : super(
          templateName,
          fieldName,
          value,
        );
}

class UpdateFieldTemplateEvent<T> extends ManageFieldTemplateEvent<T> {
  const UpdateFieldTemplateEvent(String templateName, String fieldName, T value)
      : super(
          templateName,
          fieldName,
          value,
        );
}

class RemoveFieldTemplateEvent extends ProjectEvent {
  final String templateName;
  final String fieldName;

  const RemoveFieldTemplateEvent(this.templateName, this.fieldName);

  @override
  List<Object?> get props => [templateName, fieldName];
}

class NewStageEvent extends ProjectEvent {
  final String name;

  const NewStageEvent(this.name);

  @override
  List<Object?> get props => [name];
}
