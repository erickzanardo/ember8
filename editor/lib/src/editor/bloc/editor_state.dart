import 'package:equatable/equatable.dart';

enum EditorTab {
  scripts,
  sprites,
  templates,
  stages,
}

class EditorState extends Equatable {
  final EditorTab currentTab;

  const EditorState({
    this.currentTab = EditorTab.scripts,
  });

  @override
  List<Object?> get props => [currentTab];

  EditorState copyWith({
    EditorTab? currentTab,
    List<String>? openScripts,
    String? currentOpenScript,
  }) {
    return EditorState(
        currentTab: currentTab ?? this.currentTab,
    );
  }
}
