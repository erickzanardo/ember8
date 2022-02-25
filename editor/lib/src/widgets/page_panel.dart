import 'package:editor/src/widgets/spacings.dart';
import 'package:flutter/material.dart';

class PagePanel extends StatelessWidget {

  const PagePanel({ Key? key, required this.child, }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(lg),
        child: child,
    );
  }
}

