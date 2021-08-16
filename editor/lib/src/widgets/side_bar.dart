import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final List<Widget> children;

  const SideBar({
    Key? key,
    this.children = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (children.isEmpty)
        const Text('Empty'),
      ...children,
    ]);
  }
}
