import 'package:flutter/material.dart';

class Tab extends StatelessWidget {

  final String label;
  final bool selected;
  final VoidCallback onClick;

  const Tab({
    required this.label,
    required this.onClick,
    Key? key,
    this.selected = false,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onClick,
          child: Container(
              height: 50,
              child: Center(child: Text(label)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: selected
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                      ),
                  ),
              ),
          ),
        ),
    );
  }
}
