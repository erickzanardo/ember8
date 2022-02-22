part of 'project.dart';

/// {@template project_template_field_model}
///
/// Model of a template field
///
/// {@endtemplate}
class ProjectTemplateField<T> extends Equatable {

  /// {@macro project_template_field_model}
  const ProjectTemplateField({
    this.id,
    required this.templateId,
    required this.name,
    required this.value,
  });

  /// Id of this field
  final String? id;
  /// Id of the template that this field belongs to
  final String templateId;
  /// Name of the field
  final String name;
  /// Value of this field
  final T value;

  @override
  List<Object?> get props => [id, templateId, name, value];
}

/// {@template project_template_model}
///
/// Model of a template
///
/// {@endtemplate}
class ProjectTemplate extends Equatable {
  /// {@macro project_template_field_model}
  const ProjectTemplate({
    this.id,
    required this.projectId,
    required this.name,
  });

  /// Id of this template
  final String? id;
  /// Id of the project this template belongs to
  final String projectId;
  /// Name of this template
  final String name;

  @override
  List<Object?> get props => [id, projectId, name];
}
