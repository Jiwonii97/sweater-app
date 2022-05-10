import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class GuideText extends StatelessWidget {
  // final String guide;
  final String guideText;
  GuideText({
    Key? key,
    required this.guideText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(60, 90, 60, 0),
      //   padding:EdgeInsets.all(80),
      // child: Text(
      child: WrappedKoreanText(
        // child: WordBreakText(
        // guidePhrase[guide],
        guideText,
        style: Theme.of(context).textTheme.subtitle2?.copyWith(
            color:
                Theme.of(context).textTheme.subtitle2!.color!.withOpacity(0.3)),
        textAlign: TextAlign.center,
      ),
    );
  }
}
