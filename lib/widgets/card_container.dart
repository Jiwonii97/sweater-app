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
    return SizedBox(
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
            child: child));
  }
}
