import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/components/change_coordi_button.dart';
import 'dart:ui';

class CoordiSection extends StatelessWidget {
  const CoordiSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: Column(children: [
                    SizedBox(
                      height: 150,
                      child: Column(children: <Widget>[
                        context.watch<CoordiProvider>().isReadyCoordiState
                            ? (context
                                    .watch<CoordiProvider>()
                                    .coordiList
                                    .isNotEmpty
                                ? Column(
                                    children: [
                                      Text(context
                                          .watch<CoordiProvider>()
                                          .getOuter()),
                                      Text(context
                                          .watch<CoordiProvider>()
                                          .getTopCloth()),
                                      Text(context
                                          .watch<CoordiProvider>()
                                          .getBottomCloth()),
                                    ],
                                  )
                                : const Text("코디 정보가 없어요 :("))
                            : CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color?>(
                                    Colors.blue[100]),
                                backgroundColor: Colors.blue[600],
                              ),
                      ]),
                    ),
                    const ChangeCoordiButton(),
                  ])),
            )));
  }
}
