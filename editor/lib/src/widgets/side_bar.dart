import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final List<Widget> children;

  const SideBar({
    Key? key,
    this.children = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(children: [
        if (children.isEmpty)
          const Text('Empty'),
        ...children,
      ]),
    );
  }
}
