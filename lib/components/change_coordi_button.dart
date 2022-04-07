import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';

class ChangeCoordiButton extends StatelessWidget {
  const ChangeCoordiButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _coordiIndexConsumer = Provider.of<CoordiProvider>(context);
    int idx = _coordiIndexConsumer.idx;
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          IconButton(
              icon: const Icon(Icons.navigate_before, color: Colors.black),
              onPressed: () => _coordiIndexConsumer.nextCoordi()),
          IconButton(
              icon: const Icon(Icons.navigate_next, color: Colors.black),
              onPressed: () => _coordiIndexConsumer.prevCoordi())
        ]);
  }
}
