import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 180.0,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color?>(
                Theme.of(context).colorScheme.primary),
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
        ));
  }
}
