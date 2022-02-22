part of 'templates_bloc.dart';

class TemplatesState extends Equatable {
  const TemplatesState({
    required this.templates,
    required this.fields,
  });

  const TemplatesState.initial()
      : this(
          templates: const [],
          fields: const [],
        );

  final List<ProjectTemplate> templates;
  final List<ProjectTemplateField> fields;

  @override
  List<Object> get props => [templates, fields];

  TemplatesState copyWith({
    List<ProjectTemplate>? templates,
    List<ProjectTemplateField>? fields,
  }) {
    return TemplatesState(
      templates: templates ?? this.templates,
      fields: fields ?? this.fields,
    );
  }
}
