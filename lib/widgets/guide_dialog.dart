import 'package:flutter/material.dart';
import 'package:sweater/theme/sweater_icons.dart';

class GuideDialog extends StatelessWidget {
  const GuideDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        height: 530,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(SweaterIcons.times)),
            ]),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset('assets/delete_guide.png'))
          ],
        ));
  }
}
