part of 'project.dart';

class ProjectTemplateField<T> extends Equatable {
  final String name;
  final T value;

  const ProjectTemplateField(this.name, this.value);

  @override
  List<Object?> get props => [name, value];
}

class ProjectTemplate extends Equatable {
  final String name;
  final List<ProjectTemplateField> fields;

  const ProjectTemplate(this.name, this.fields);

  @override
  List<Object?> get props => [name, fields];

  ProjectTemplate copyWithNewField(ProjectTemplateField field) {
    return ProjectTemplate(
      name,
      [
        ...fields,
        field,
      ],
    );
  }
}
