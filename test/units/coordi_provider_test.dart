import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweater/module/coordi.dart';
import 'package:sweater/module/forecast.dart';
import 'package:sweater/module/user.dart';
import 'package:sweater/providers/coordi_provider.dart';
import 'package:sweater/providers/user_provider.dart';
import 'package:sweater/module/gender.dart';
import 'package:sweater/module/constitution.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// CancelableOperation? _coordiListFuture;

// List<Coordi> _coordiList = [];
// Coordi _coordi = Coordi("", []);
// int _coordiIdx = 0;
// bool _isReadyCoordiState = false;
// bool _isUpdateCoordiState = false;

// Coordi get coordi => _coordi;

// List<Coordi> get coordiList => _coordiList;
// int get coordiIdx => _coordiIdx;
// bool get isReadyCoordiState => _isReadyCoordiState;
// bool get isUpdateCoordiState => _isUpdateCoordiState;

main() {
  CoordiProvider coordiProvider = CoordiProvider();
  test('UserProvider 생성', () async {
    expect(coordiProvider.coordiList, []);
    expect(coordiProvider.coordiIdx, 0);
  });
  test('UserProvider 코디 불러오기', () async {
    expect(coordiProvider.coordiList, []);

    Forecast currentForecast = Forecast();
    DateTime specificDate =
        DateFormat("yyyy-MM-dd HH:mm").parse("2022-05-17 04:24");
    currentForecast.initForecast(specificDate, 26, 28, "맑음", 0, 2.8);
    User user = User(Gender.man, Constitution.feelNormal);

    bool isRequestSuccess =
        await coordiProvider.requestCoordiList(currentForecast, user);
    expect(isRequestSuccess, true);
    expect(coordiProvider.coordiList.length, 20);
    for (Coordi coordi in coordiProvider.coordiList) {
      expect(coordi.getCoordiInfo().isNotEmpty, true);
      expect(coordi.getIllustUrl().isNotEmpty, true);
      //코디 스타일 스트링을 불러오는 메소드 추가("getCoordiStyle() => 아메리칸 캐쥬얼")
      // expect(coordi.style.isNotEmpty, true);
    }
  });
  test('UserProvider 다음 코디, 이전 코디', () async {
    expect(coordiProvider.coordiIdx, 0);
    coordiProvider.nextCoordi();
    expect(coordiProvider.coordiIdx, 1);
    coordiProvider.prevCoordi();
    expect(coordiProvider.coordiIdx, 0);
    coordiProvider.prevCoordi();
    expect(coordiProvider.coordiIdx, 19);
    coordiProvider.nextCoordi();
    expect(coordiProvider.coordiIdx, 0);
  });
}
