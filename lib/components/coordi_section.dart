import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/components/change_coordi_button.dart';
import 'dart:ui';

class CoordiSection extends StatelessWidget {
  // final Widget child;
  const CoordiSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _coordiIndexConsumer = Provider.of<CoordiProvider>(context);
    int idx = _coordiIndexConsumer.idx;
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
                    Consumer<CoordiProvider>(
                      builder: (context, value, child) => SizedBox(
                        height: 150,
                        child: Text(value.coordi_lists.length != 0
                            ? value.coordi_lists[0].docs[idx].data().toString()
                            : value.dummy.values
                                .map((value) => (value))
                                .toString()),
                      ),
                    ),
                    const ChangeCoordiButton(),
                  ])),
            ))));
  }
}
