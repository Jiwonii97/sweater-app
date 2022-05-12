import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/widgets/loading.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sweater/widgets/card_container.dart';

import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class CoordiSection extends StatefulWidget {
  const CoordiSection({Key? key}) : super(key: key);

  @override
  State<CoordiSection> createState() => _CoordiSectionState();
}

class _CoordiSectionState extends State<CoordiSection> {
  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 0.8, initialPage: 999);
    return context.watch<CoordiProvider>().isUpdateCoordiState
        ? Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(children: <Widget>[
              Text(
                "오늘의 추천 코디",
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              context.watch<CoordiProvider>().coordiList.isEmpty
                  ? const Text("no data")
                  : SizedBox(
                      height: 324,
                      child: PageView.builder(
                          controller: controller,
                          itemBuilder: (_, index) {
                            return CardContainer(
                                child: CoordiView(
                                    coordi: context
                                        .watch<CoordiProvider>()
                                        .coordiList[index %
                                            context
                                                .watch<CoordiProvider>()
                                                .coordiList
                                                .length]
                                        .getCoordiInfo(),
                                    coordiIllust: context
                                        .watch<CoordiProvider>()
                                        .coordiList[index %
                                            context
                                                .watch<CoordiProvider>()
                                                .coordiList
                                                .length]
                                        .getIllustUrl()));
                          })),
            ]),
          )
        : const Loading(height: 396);
  }
}

class CoordiView extends StatelessWidget {
  final List coordi;
  final List coordiIllust;
  const CoordiView({Key? key, required this.coordi, required this.coordiIllust})
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
