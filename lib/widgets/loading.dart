import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final double height;
  const Loading({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color?>(
                Theme.of(context).colorScheme.primary),
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
        ));
  }
}
