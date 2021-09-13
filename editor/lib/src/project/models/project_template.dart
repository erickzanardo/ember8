part of 'project.dart';

class ProjectTemplateField<T> extends Equatable {
  final String name;
  final T value;

  const ProjectTemplateField(this.name, this.value);

  @override
  List<Object?> get props => [name, value];

  static ProjectTemplateField fromData(List data) {
    final name = data[0] as String;
    final value = data[1];
    final type = data[2] as String;

    if (type == 'S') {
      return ProjectTemplateField<String>(name, value as String);
    } else if (type == 'D') {
      return ProjectTemplateField<double>(name, value as double);
    } else if (type == 'B') {
      return ProjectTemplateField<bool>(name, value as bool);
    } else {
      throw ArgumentError('Unknown type: $type');
    }
  }

  List<dynamic> toData() {
    late String type;

    if (T == String) {
      type = 'S';
    } else if (T == double) {
      type = 'D';
    } else if (T == bool) {
      type = 'B';
    } else {
      throw ArgumentError('Unknown type: $T');
    }

    return [name, value, type];
  }
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

  static ProjectTemplate fromData(List<dynamic> data) {
    final name = data[0] as String;

    final fieldsData = data[1] as List<List<dynamic>>;
    final fields = fieldsData
        .map(
          (data) => ProjectTemplateField.fromData(data),
        )
        .toList();

    return ProjectTemplate(name, fields);
  }

  List<dynamic> toData() {
    return [
      name,
      fields.map((field) => field.toData()).toList(),
    ];
  }
}
