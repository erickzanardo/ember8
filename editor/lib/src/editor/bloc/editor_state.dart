import 'package:equatable/equatable.dart';

enum EditorTab {
  scripts,
  sprites,
  stages,
}

class EditorState extends Equatable {
  final EditorTab currentTab;

  final List<String> openScripts;
  final String currentOpenScript;

  const EditorState({
    this.currentTab = EditorTab.scripts,
    this.openScripts = const [],
    this.currentOpenScript = '',
  });

  @override
  List<Object?> get props => [currentTab, openScripts, currentOpenScript];

  EditorState copyWith({
    EditorTab? currentTab,
    List<String>? openScripts,
    String? currentOpenScript,
  }) {
    return EditorState(
        currentTab: currentTab ?? this.currentTab,
        openScripts: openScripts ?? this.openScripts,
        currentOpenScript: currentOpenScript ?? this.currentOpenScript,
    );
  }
}
