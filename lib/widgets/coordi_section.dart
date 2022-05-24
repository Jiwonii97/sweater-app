import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/widgets/filter_drawer.dart';
import 'package:sweater/widgets/loading.dart';
import 'package:sweater/widgets/card_container.dart';
import 'package:sweater/theme/sweater_icons.dart';

import 'package:sweater/providers/user_provider.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:url_launcher/link.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class CoordiSection extends StatefulWidget {
  final Function openFilterDrawer;
  const CoordiSection({Key? key, required this.openFilterDrawer})
      : super(key: key);

  @override
  State<CoordiSection> createState() => _CoordiSectionState();
}

class _CoordiSectionState extends State<CoordiSection> {
  @override
  Widget build(BuildContext context) {
    final controller = PageController(
        viewportFraction: 0.8,
        initialPage: context.watch<CoordiProvider>().pageIndex);
    final pageLength = context.watch<CoordiProvider>().coordiList.length;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                    height: 32,
                    child: Text(
                      "오늘의 추천 코디",
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    )),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      height: 32,
                      width: 32,
                      child: IconButton(
                        icon: Icon(SweaterIcons.sliders_h,
                            size: 20,
                            color: Theme.of(context).colorScheme.onBackground),
                        onPressed: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              builder: (context) {
                                return Container(
                                  child: FilterDrawer(),
                                  height: 600,
                                );
                              });
                        },
                      )))
            ],
          ),
        ),
        const SizedBox(height: 12),
        context.watch<CoordiProvider>().coordiList.isEmpty &&
                context
                    .watch<CoordiProvider>()
                    .isUpdateCoordiState // 코디 부분 빌드 build
            ? noDataCard()
            : SizedBox(
                height: 400,
                child: PageView.builder(
                    controller: controller,
                    itemCount: context.watch<CoordiProvider>().isAllLoaded
                        ? pageLength
                        : pageLength + 1,
                    itemBuilder: (_, index) {
                      if (index == pageLength) {
                        if (context
                            .watch<CoordiProvider>()
                            .isUpdateCoordiState) {
                          return moreLoadCard();
                        } else
                          return CardContainer(
                            child: const Loading(height: 396),
                          );
                      } else
                        return coordiViewCard(index);
                    }),
              ),
      ]),
    );
    // : const Loading(height: 396);
  }

  Widget coordiViewCard(int index) {
    return CardContainer(
        child: CoordiView(
      coordi: context.watch<CoordiProvider>().coordiList[index].getCoordiInfo(),
      coordiIllust:
          context.watch<CoordiProvider>().coordiList[index].getIllustUrl(),
      url: context.watch<CoordiProvider>().coordiList[index].url,
      style: context.watch<CoordiProvider>().coordiList[index].style,
    ));
  }

  Widget moreLoadCard() {
    return GestureDetector(
      onTap: () => {
        context.read<CoordiProvider>().requestCoordiList(
            context.read<WeatherProvider>().getCurrentWeather(),
            context.read<UserProvider>().user,
            pageKey: context.read<CoordiProvider>().pageKey,
            pageIndex: context.read<CoordiProvider>().pageIndex + 1)
      }, // 여기서 더 불러오기
      child: CardContainer(
        child: Column(
          children: [
            const SizedBox(height: 48),
            Icon(
              SweaterIcons.plus,
              size: 70,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(height: 48),
            Text("코디 더 불러오기", style: Theme.of(context).textTheme.headline6)
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  Widget noDataCard() {
    int currentHour = DateTime.now().hour;
    return SizedBox(
        width: 264,
        height: 400,
        child: CardContainer(
            child: Column(
          children: [
            if (6 <= currentHour && currentHour <= 18)
              Image.asset('assets/no-data-black.png')
            else
              Image.asset('assets/no-data-white.png'),
            const SizedBox(height: 16),
            Text("데이터가 없습니다.", style: Theme.of(context).textTheme.headline6)
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )));
  }
}

class CoordiView extends StatelessWidget {
  final List coordi;
  final List coordiIllust;
  final String url;
  final String style;
  CoordiView({
    Key? key,
    required this.coordi,
    required this.coordiIllust,
    required this.url,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String detail = "";
    int clothCount = coordiIllust.length;
    List<Widget> coordiList = [];

    // 코디 위치 결정
    if (clothCount == 1) {
      coordiList.add(illustView(coordiIllust[0], 64, 32));
    } else if (clothCount == 2) {
      coordiList.add(illustView(coordiIllust[0], 19, 0));
      coordiList.add(illustView(coordiIllust[1], 123, 42));
    } else if (clothCount == 3) {
      coordiList.add(illustView(coordiIllust[0], 16, -3));
      coordiList.add(illustView(coordiIllust[1], 128, -3));
      coordiList.add(illustView(coordiIllust[2], 80, 64));
    } else if (clothCount == 4) {
      coordiList.add(illustView(coordiIllust[2], 84, -10));
      coordiList.add(illustView(coordiIllust[1], 146, 50));
      coordiList.add(illustView(coordiIllust[3], 60, 70));
      coordiList.add(illustView(coordiIllust[0], 0, 10));
    }

    // 상세 설명 텍스트
    for (String cloth in coordi) {
      detail += "#${cloth}  ";
    }
    ;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Text(style, style: Theme.of(context).textTheme.subtitle2),
        ),
        Container(
          width: 264,
          height: 228,
          child: Stack(children: coordiList),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: 264,
          height: 60,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: WrappedKoreanText(
                detail,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontWeight: FontWeight.bold),
              )),
        ),
        Link(
          uri: Uri.parse(url),
          target: LinkTarget.blank,
          builder: (BuildContext ctx, FollowLink? openLink) {
            return url != ""
                ? Container(
                    width: 232,
                    height: 32,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          primary: Theme.of(context).colorScheme.surface,
                          elevation: 0),
                      icon: Icon(
                        SweaterIcons.external_link_alt,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 14,
                      ),
                      onPressed: openLink,
                      label: Text(
                        decideLinkButtonText(url),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ))
                : Container();
          },
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

  String decideLinkButtonText(String url) {
    String returnSource = "링크 보러가기";
    List sourceList = [
      ['www.musinsa.com', '무신사닷컴(www.musinsa.com)'],
    ];

    for (var source in sourceList) {
      if (url.contains(source[0])) {
        returnSource = source[1];
        break;
      }
    }
    return returnSource;
  }
}
