import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/weather.dart';
import 'package:sweater/providers/user_info.dart';
import 'package:sweater/components/change_coordi_button.dart';
import 'dart:ui';

class CoordiSection extends StatelessWidget {
  // final Widget child;
  const CoordiSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _coordiConsumer = Provider.of<CoordiProvider>(context);
    int coordiIdx = _coordiConsumer.coordiIdx;

    return SizedBox(
        child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white.withOpacity(0.6),
            child: Center(
                child: SizedBox(
              height: 200,
              child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 24.0,
                    sigmaY: 24.0,
                  ),
                  child: Column(children: [
                    SizedBox(
                      height: 150,
                      child: Column(children: <Widget>[
                        _coordiConsumer.initCoordiState
                            ? Column(
                                children: [
                                  // const Text("오늘의 추천 코디!"),
                                  Text(context
                                      .watch<CoordiProvider>()
                                      .getOuter()),
                                  Text(context
                                      .watch<CoordiProvider>()
                                      .getTopCloth()),
                                  Text(context
                                      .watch<CoordiProvider>()
                                      .getBottomCloth()),
                                  // Text(context
                                  //     .read<CoordiProvider>()
                                  //     .getBottomCloth()),
                                  // const Text('어때요?'),
                                  // ReqCoordiInfo(),
                                ],
                              )
                            : CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color?>(
                                    Colors.blue[100]),
                                backgroundColor: Colors.blue[600],
                              ),
                      ]),
                    ),
                    // ),
                    const ChangeCoordiButton(),
                  ])),
            ))));
  }
}
