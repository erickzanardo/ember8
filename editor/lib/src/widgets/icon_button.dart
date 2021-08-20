import 'package:flutter/material.dart';

class IconButton extends StatelessWidget {
  final String tooltip;
  final IconData data;
  final VoidCallback onClick;
  final bool primary;

  const IconButton({
    Key? key,
    required this.tooltip,
    required this.data,
    required this.onClick,
    this.primary = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Tooltip(
          message: tooltip,
          child: GestureDetector(
              onTap: onClick,
              child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Icon(
                      data,
                      color: primary
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).iconTheme.color,
                  ),
              ),
          ),
        ),
    );
  }
}
