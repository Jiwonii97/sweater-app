import 'package:flutter/material.dart';
import 'package:sweater/theme/global_theme.dart';
import 'package:sweater/theme/sweater_icons.dart';
import 'package:page_view_indicators/step_page_indicator.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class FirstGuide extends StatefulWidget {
  final Function() startPressed;
  const FirstGuide({Key? key, required this.startPressed}) : super(key: key);

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
        _buildPageView(),
        _buildStepIndicator(),
      ],
    );
  }

  _buildPageView() {
    final List<String> firstGuideImages = <String>[
      'location_manage_first_guide.png',
      'add_location_first_guide.png',
      'gender_first_guide.png',
      'constitution_first_guide.png',
      'ready_first_guide.png'
    ];
    final List<String> guideText = <String>[
      "메뉴 > 위치관리를 눌러 지역을 선택하고 지역에 맞는 코디를 추천받을 수 있습니다.",
      "메뉴 > 위치관리 > + 버튼을 눌러 지역을 추가할 수 있습니다.",
      "메뉴 > 성별 탭을 눌러 본인의 성별에 맞는 코디를 추천받을 수 있습니다.",
      "메뉴 > 체질관리 탭을 눌러 추천되는 코디를 더 시원하게 또는 더 따뜻하게 설정할 수 있습니다.",
      " "
    ];
    return Expanded(
      child: PageView.builder(
        itemCount: 5,
        controller: PageController(initialPage: 0),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: EdgeInsets.fromLTRB(8, 32, 8, 32),
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset('assets/guide/${firstGuideImages[index]}'),
                  index != 4
                      ? WrappedKoreanText(guideText[index],
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2)
                      : ElevatedButton(
                          child: Text("시작하기"),
                          style: ElevatedButton.styleFrom(
                              primary: GlobalTheme.lightTheme.primaryColor,
                              onPrimary: Color.fromRGBO(255, 255, 255, 1),
                              fixedSize: Size(181, 36),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              )),
                          onPressed: () => widget.startPressed(),
                        )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        itemCount: 5,
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
