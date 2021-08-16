import 'package:equatable/equatable.dart';

enum EditorTab {
  scripts,
  sprites,
  stages,
}

enum EditorScriptType {
  controller,
  dpad,
  action,
}

class EditorScript extends Equatable {
  final EditorScriptType type;
  final String name;
  final String body;

  const EditorScript({
    required this.type,
    required this.name,
    required this.body,
  });

  @override
  List<Object?> get props => [type, name, body];
}

class EditorState extends Equatable {
  final EditorTab currentTab;
  final List<EditorScript> scripts;

  const EditorState({
    this.currentTab = EditorTab.scripts,
    this.scripts = const [],
  });

  @override
  List<Object?> get props => [currentTab, scripts];

  EditorState copyWith({
    EditorTab? currentTab,
    List<EditorScript>? scripts,
  }) {
    return EditorState(
        currentTab: currentTab ?? this.currentTab,
        scripts: scripts ?? this.scripts,
    );
  }
}
