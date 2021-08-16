import 'package:equatable/equatable.dart';

import 'editor_state.dart';

abstract class EditorEvent extends Equatable {
  const EditorEvent();
}

class SelectTabEvent extends EditorEvent {
  final EditorTab newTab;

  const SelectTabEvent(this.newTab);

  @override
  List<Object?> get props => [newTab];
}
