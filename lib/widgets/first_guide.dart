import 'package:flutter/material.dart';
import 'package:sweater/theme/global_theme.dart';
import 'package:sweater/theme/sweater_icons.dart';
import 'package:page_view_indicators/step_page_indicator.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class FirstGuide extends StatefulWidget {
  final Function() endTutorial;
  const FirstGuide({Key? key, required this.endTutorial}) : super(key: key);

  @override
  _FirstGuideState createState() {
    return _FirstGuideState();
  }
}

class _FirstGuideState extends State<FirstGuide> {
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: _buildBody(),
    );
  }

  _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () => widget.endTutorial(),
                child: Text(
                  "건너뛰기",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.white),
                ))
          ],
        ),
        _buildPageView(),
        _buildStepIndicator()
      ],
    );
  }

  _buildPageView() {
    final List<String> firstGuideImages = <String>[
      'weather_section_guide.png',
      'coordi_section_guide.png',
      "link_guide.png",
      "filter_button_guide.png",
      'menu_guide.png',
      'ready_first_guide.png'
    ];
    final List<String> guideText = <String>[
      "날씨 예보를 클릭해 클릭한 예보를 기준으로 코디를 추천받을 수 있습니다.",
      "날씨에 맞는 코디를 추천받을 수 있습니다.",
      "하단의 링크를 통해 실제 코디를 볼 수 있습니다.",
      "필터 버튼을 통해 유저가 원하는 옷만 추천되도록 설정할 수 있습니다.",
      "상단의 메뉴 버튼을 누르면 위치, 성별, 체질 설정을 할 수 있습니다.",
      " "
    ];
    return Expanded(
      child: PageView.builder(
        itemCount: 6,
        controller: PageController(initialPage: 0),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: EdgeInsets.fromLTRB(8, 32, 8, 32),
              child: Column(
                children: [
                  Expanded(
                    flex: 10,
                    child:
                        Image.asset('assets/guide/${firstGuideImages[index]}'),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    flex: 1,
                    child: index != 5
                        ? WrappedKoreanText(guideText[index],
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(color: Colors.white))
                        : SizedBox(
                            height: 36,
                            child: ElevatedButton(
                              child: Text("시작하기"),
                              style: ElevatedButton.styleFrom(
                                  primary: GlobalTheme.lightTheme.primaryColor,
                                  onPrimary: Color.fromRGBO(255, 255, 255, 1),
                                  fixedSize: Size(181, 36),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                  )),
                              onPressed: () => widget.endTutorial(),
                            )),
                  )
                ],
              ));
        },
        onPageChanged: (int index) {
          _currentPageNotifier.value = index;
        },
      ),
    );
  }

  _buildStepIndicator() {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(8.0),
      child: StepPageIndicator(
        itemCount: 6,
        stepColor: Colors.white,
        currentPageNotifier: _currentPageNotifier,
        size: 16,
        onPageSelected: (int index) {
          if (_currentPageNotifier.value > index)
            _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
