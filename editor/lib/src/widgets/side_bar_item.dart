import 'package:flutter/material.dart';

class SideBarItem extends StatefulWidget {
  final Widget child;
  final VoidCallback onClick;

  const SideBarItem({
    Key? key,
    required this.child,
    required this.onClick,
  }) : super(key: key);

  @override
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  bool _beingHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        color:
            _beingHovered ? Theme.of(context).hoverColor : Colors.transparent,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            setState(() => _beingHovered = true);
          },
          onExit: (_) {
            setState(() => _beingHovered = false);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
