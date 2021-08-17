import 'package:equatable/equatable.dart';

enum EditorTab {
  scripts,
  sprites,
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
  }) {
    return EditorState(
        currentTab: currentTab ?? this.currentTab,
    );
  }
}
