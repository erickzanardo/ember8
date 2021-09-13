part of 'project.dart';

enum ProjectScriptType {
  controller,
  dpad,
  action,
}

class ProjectScript extends Equatable {
  final ProjectScriptType type;
  final String name;
  final String body;

  const ProjectScript({
    required this.type,
    required this.name,
    required this.body,
  });

  @override
  List<Object?> get props => [type, name, body];

  ProjectScript copyWithNewBody(String body) {
    return ProjectScript(
      type: type,
      name: name,
      body: body,
    );
  }

  List<dynamic> toData() {
    late String stringType;
    switch(type) {
      case ProjectScriptType.controller:
        stringType = 'C';
        break;
      case ProjectScriptType.dpad:
        stringType = 'D';
        break;
      case ProjectScriptType.action:
        stringType = 'A';
        break;
    }
    return [stringType, name, body];
  }

  static ProjectScript fromData(List<dynamic> data) {
    final type = data[0] as String;
    final name = data[1] as String;
    final body = data[2] as String;

    late ProjectScriptType scriptType;

    if (type == 'C') {
      scriptType = ProjectScriptType.controller;
    } else if (type == 'D') {
      scriptType = ProjectScriptType.dpad;
    } else if (type == 'A') {
      scriptType = ProjectScriptType.action;
    } else {
      throw ArgumentError('Unknown type: $type');
    }

    return ProjectScript(type: scriptType, name: name, body: body);
  }
}


