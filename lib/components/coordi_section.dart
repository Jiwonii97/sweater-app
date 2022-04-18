import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/components/change_coordi_button.dart';
import 'package:sweater/providers/weather.dart';
import 'package:sweater/theme/global_theme.dart';
import 'dart:ui';
import 'package:sweater/theme/sweater_icons.dart';

import 'package:flutter_svg/flutter_svg.dart';

class CoordiSection extends StatelessWidget {
  const CoordiSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _coordiIndexConsumer = Provider.of<CoordiProvider>(context);
    int coordiIdx = _coordiIndexConsumer.coordiIdx;
    return Padding(
      padding: const EdgeInsets.all(16),
      // color: Colors.green,
      child: Column(children: <Widget>[
        Text(
          "추천 코디",
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        context.watch<CoordiProvider>().isReadyCoordiState
            ? context.watch<CoordiProvider>().coordiList.length == 0
                ? Text("no data")
                : CoordiView(
                    coordi: context
                        .watch<CoordiProvider>()
                        .coordiList[coordiIdx]
                        .getCoordiInfo(),
                    coordiIllust:
                        context.watch<CoordiProvider>().coordi.getIllustUrl())
            : CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color?>(Colors.blue[100]),
                backgroundColor: Colors.blue[600],
              ),
        SizedBox(
          width: 120,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CoordiButton(
                onPressed: context.read<CoordiProvider>().prevCoordi,
                // onPressed: () {
                //   if (coordiIndex != 0)
                //     coordiIndex -= 1;
                // },
                icon: SweaterIcons.arrow_left),
            const Spacer(
              flex: 1,
            ),
            CoordiButton(
                onPressed: context.read<CoordiProvider>().nextCoordi,
                // onPressed: () {
                //   if (context.read<CoordiManager>().coordiList.length >
                //       coordiIndex)
                //     coordiIndex += 1;
                //   else {
                //     context.read<CoordiManager>().addCoordi();
                //     coordiIndex += 1;
                //   }
                // },
                icon: SweaterIcons.arrow_right),
          ]),
        ),
      ]),
    );
  }
}

class CoordiButton extends StatelessWidget {
  Function onPressed;
  IconData icon;
  CoordiButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    const buttonWidth = 40.0;
    return Container(
      height: buttonWidth,
      width: buttonWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(buttonWidth / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 3), // changes position of shadow
          )
        ],
      ),
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        padding: EdgeInsets.zero,
        icon: Icon(
          icon,
          size: 16,
        ),
        color: Theme.of(context).colorScheme.onSurface,
        onPressed: () => onPressed(),
      ),
    );
  }
}

class CoordiView extends StatelessWidget {
  List coordi;
  List coordiIllust;
  CoordiView({Key? key, required this.coordi, required this.coordiIllust})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String outer, top, bottomt;
    return Container(
      width: 288,
      height: 160,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              coordi.length,
              (index) => coordi[index] != ""
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                      color: Theme.of(context).colorScheme.surface,
                      child: Text("# ${coordi[index]}",
                          style: Theme.of(context).textTheme.bodyText2),
                    )
                  : Container(),
            ),
          )
          // [

          // Expanded(
          //   flex: 1,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       // 아우터
          //       illustView("assets/weather/rainy.svg"),
          //       // illustView(coordiIllust[0]),
          //       // 상의
          //       illustView("assets/weather/sunny.svg"),
          //       // coordiIllust[3] == "" ? illustView(coordiIllust[1]) : illustView(coordiIllust[3]),
          //     ],
          //   ),
          // ),
          // Expanded(
          //   flex: 1,
          //   child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Container(
          //           // color: Colors.green,
          //           padding: const EdgeInsets.symmetric(vertical: 12),
          //           width: 144,
          //           height: 144,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: List.generate(
          //               coordi.length,
          //               (index) => Container(
          //                 margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          //                 padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
          //                 color: Theme.of(context).colorScheme.surface,
          //                 child: Text("# ${coordi[index]}",
          //                     style: Theme.of(context).textTheme.bodyText2),
          //               ),
          //             ),
          //           ),
          //         ),
          //         illustView("assets/weather/cloudy.svg"),
          //       ]),
          // )
          // ],
          ),
    );
  }

  Widget illustView(String illust) {
    return SizedBox(
      width: 144,
      child: illust != "" ? SvgPicture.asset(illust) : Container(),
      height: 144,
    );
  }
}
