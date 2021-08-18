import 'package:flutter/material.dart';

class SideBarItem extends StatelessWidget {

  final Widget child;
  final VoidCallback onClick;

  const SideBarItem({
    Key? key,
    required this.child,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: child,
        ),
      ),
    );
  }
}

