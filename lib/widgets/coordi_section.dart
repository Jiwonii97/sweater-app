import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/widgets/change_coordi_button.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:sweater/theme/global_theme.dart';
import 'dart:ui';
import 'package:sweater/theme/sweater_icons.dart';
import 'package:sweater/widgets/loading.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoordiSection extends StatelessWidget {
  const CoordiSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _coordiIndexConsumer = Provider.of<CoordiProvider>(context);
    int coordiIdx = _coordiIndexConsumer.coordiIdx;
    return context.watch<CoordiProvider>().isUpdateCoordiState
        ? Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: <Widget>[
              Text(
                "추천 코디",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              context.watch<CoordiProvider>().coordiList.isEmpty
                  ? const Text("no data")
                  : CoordiView(
                      coordi: context
                          .watch<CoordiProvider>()
                          .coordiList[coordiIdx]
                          .getCoordiInfo(),
                      coordiIllust: context
                          .watch<CoordiProvider>()
                          .coordiList[coordiIdx]
                          .getIllustUrl()),
              SizedBox(
                width: 120,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CoordiButton(
                      onPressed: context.read<CoordiProvider>().prevCoordi,
                      icon: SweaterIcons.arrow_left),
                  const Spacer(
                    flex: 1,
                  ),
                  CoordiButton(
                      onPressed: context.read<CoordiProvider>().nextCoordi,
                      icon: SweaterIcons.arrow_right),
                ]),
              ),
            ]),
          )
        : const Loading(height: 396);
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
    String detail = "";
    int clothCount = coordiIllust.length;
    List<Widget> coordiList = [];

    // 코디 위치 결정
    if (clothCount == 1) {
      coordiList.add(illustView(coordiIllust[0], 64, 32));
    } else if (clothCount == 2) {
      coordiList.add(illustView(coordiIllust[0], 19, 23));
      coordiList.add(illustView(coordiIllust[1], 123, 72));
    } else if (clothCount == 3) {
      coordiList.add(illustView(coordiIllust[0], 16, 17));
      coordiList.add(illustView(coordiIllust[1], 128, 17));
      coordiList.add(illustView(coordiIllust[2], 80, 84));
    } else if (clothCount == 4) {
      coordiList.add(illustView(coordiIllust[2], 84, 0));
      coordiList.add(illustView(coordiIllust[1], 146, 60));
      coordiList.add(illustView(coordiIllust[3], 60, 110));
      coordiList.add(illustView(coordiIllust[0], 0, 20));
    }

    // 상세 설명 텍스트
    for (String cloth in coordi) {
      detail += "#${cloth}  ";
    }
    ;
    return Column(
      children: [
        Container(
          width: 264,
          height: 264,
          margin: EdgeInsets.all(16),
          child: Stack(children: coordiList),
        ),
        Container(
          width: 264,
          height: 60,
          child: WrappedKoreanText(
            detail,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: List.generate(
          //     coordi.length,
          //     (index) => coordi[index] != ""
          //         ? Container(
          //             margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          //             padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
          //             color: Theme.of(context).colorScheme.surface,
          //             child: Text("# ${coordi[index]}",
          //                 style: Theme.of(context).textTheme.bodyText2),
          //           )
          //         : Container(),
          //   ),
          // ),
        ),
      ],
    );
  }

  Widget illustView(String illust, double X, double Y) {
    return illust != ""
        ? Positioned(
            top: Y,
            left: X,
            child: SizedBox(
              width: 120,
              child: Image.asset(illust),
              height: 160,
            ))
        : Container();
  }
}
