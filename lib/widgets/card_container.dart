import 'dart:ui';
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final double elevation;
  const CardContainer({
    Key? key,
    required this.child,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.black.withOpacity(0.05)),
            ),
            color: Theme.of(context).colorScheme.background.withOpacity(0.4),
            child: child));
  }
}
