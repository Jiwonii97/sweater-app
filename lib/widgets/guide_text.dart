import 'dart:ui';
import 'package:flutter/material.dart';

class GuideText extends StatelessWidget {
  final String guide;
  GuideText({
    Key? key,
    required this.guide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(60, 90, 60, 0),
      //   padding:EdgeInsets.all(80),
      child: Text(
        guidePhrase[guide],
        style: Theme.of(context).textTheme.subtitle2?.copyWith(
            color:
                Theme.of(context).textTheme.subtitle2!.color!.withOpacity(0.3)),
        textAlign: TextAlign.center,
      ),
    );
  }

  Map guidePhrase = {
    "addLocation": "위치는 시,도,구 까지 설정할 수 있습니다. \n입력 예시) 동작구, 울릉군, 정읍시, ...",
    "gender": "성별 설정을 통해 본인의 성별에 맞게 코디를 \n추천받을 수 있습니다",
    "constitution": "체질 설정을 통해 본인의 체질에 맞는 코디를 \n추천받을 수 있습니다."
  };
}
