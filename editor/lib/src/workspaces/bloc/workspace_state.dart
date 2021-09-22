import 'package:equatable/equatable.dart';

class WorkspaceState extends Equatable {
  final List<String> openEditors;
  final String currentEditor;

  const WorkspaceState({
    this.openEditors = const [],
    this.currentEditor = '',
  });

  @override
  List<Object?> get props => [openEditors, currentEditor];

  WorkspaceState copyWith({
    List<String>? openEditors,
    String? currentEditor,
  }) {
    return WorkspaceState(
      openEditors: openEditors ?? this.openEditors,
      currentEditor: currentEditor ?? this.currentEditor,
    );
  }
}
