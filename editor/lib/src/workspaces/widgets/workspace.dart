import 'package:editor/src/widgets/icon_button.dart';
import 'package:editor/src/widgets/side_bar.dart';
import 'package:editor/src/widgets/side_bar_item.dart';
import 'package:editor/src/workspaces/bloc/workspace_bloc.dart';
import 'package:editor/src/workspaces/bloc/workspace_events.dart';
import 'package:editor/src/workspaces/widgets/workspace_editor.dart';
import 'package:flutter/material.dart' hide IconButton;
import 'package:flutter_bloc/flutter_bloc.dart';

class Workspace<T extends WorkspaceBloc, V> extends StatelessWidget {
  final Key addButtonKey;
  final String addButtonTooltip;
  final Future<void> Function() onAddButtonClick;
  final Widget Function(V) buildSideBarItem;
  final String Function(V) mapItemValue;
  final Widget Function(String) buildCurrent;
  final String emptyMessage;
  final List<V> items;

  const Workspace({
    Key? key,
    required this.addButtonKey,
    required this.addButtonTooltip,
    required this.onAddButtonClick,
    required this.buildSideBarItem,
    required this.mapItemValue,
    required this.items,
    required this.buildCurrent,
    required this.emptyMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      key: addButtonKey,
                      data: Icons.add,
                      tooltip: addButtonTooltip,
                      onClick: () {
                        onAddButtonClick();
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: SideBar(
                    children: items.map((e) {
                      final child = buildSideBarItem(e);
                      final value = mapItemValue(e);
                      return SideBarItem(
                        child: child,
                        onClick: () {
                          context.read<T>().add(OpenEditorEvent(value));
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: WorkspaceEditor<T>(
              emptyMessage: emptyMessage, buildCurrent: buildCurrent),
        ),
      ],
    );
  }
}
