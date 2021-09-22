import 'package:editor/src/widgets/icon_button.dart';
import 'package:flutter/material.dart' hide IconButton;

class Tab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onClick;
  final VoidCallback? onClose;

  const Tab({
    required this.label,
    required this.onClick,
    Key? key,
    this.selected = false,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(label),
                  ),
                ),
              ),
              if (onClose != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: IconButton(
                    data: Icons.close,
                    tooltip: 'Close tab',
                    onClick: onClose!,
                  ),
                ),
            ],
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: selected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).dividerColor,
              ),
              right: BorderSide(
                width: 1,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
