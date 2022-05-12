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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sweater/widgets/card_container.dart';

class CoordiSection extends StatefulWidget {
  const CoordiSection({Key? key}) : super(key: key);

  @override
  State<CoordiSection> createState() => _CoordiSectionState();
}

class _CoordiSectionState extends State<CoordiSection> {
  static int prevPageIndex = 999;

  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: 0.8, initialPage: 999);
    var _coordiIndexConsumer = Provider.of<CoordiProvider>(context);
    int coordiIdx = _coordiIndexConsumer.coordiIdx;
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
              SizedBox(
                height: 16,
              ),
              context.watch<CoordiProvider>().coordiList.isEmpty
                  ? const Text("no data")
                  : Container(
                      height: 324,
                      child: PageView.builder(
                          controller: controller,
                          onPageChanged: (index) {
                            if (prevPageIndex > index)
                              context.read<CoordiProvider>().prevCoordi();
                            else
                              context.read<CoordiProvider>().nextCoordi();
                            prevPageIndex = index;
                          },
                          // itemCount: pages.length,
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
  List coordi;
  List coordiIllust;
  CoordiView({Key? key, required this.coordi, required this.coordiIllust})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String outer, top, bottomt;
    return Container(
      width: 288,
      height: 288,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(coordiIllust.length,
                      (index) => illustView(coordiIllust[index]))),
              Container(
                // color: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: 288,
                height: 144,
                child: Column(
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
                ),
              ),
            ]),
      ),
    );
  }

  Widget illustView(String illust) {
    return illust != ""
        ? SizedBox(
            width: 96,
            child: Image.asset(illust),
            height: 96,
          )
        : Container();
  }
}
