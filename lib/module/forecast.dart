// 시간별 날씨 정보를 담고 있는 객체
class Forecast {
  // 초기값(Default) 설정
  late DateTime _time; // 시간
  late int _temp; // 기온
  late int _sTemp; // 체감 온도
  late String _sky =
      ""; // 구름 상태 - 맑음, 구름많음, 흐림, 비, 비/눈, 눈, 소나기 <- 초기화 되지 않았을 때는 "" 나오도록 수정했어요
  late int _rainRate; // 강수 확률
  late double _windSpeed; // 풍속

  //getter
  DateTime get time => _time;
  int get temp => _temp;
  int get sTemp => _sTemp;
  String get sky => _sky;
  int get rainRate => _rainRate;
  double get windSpeed => _windSpeed;

  // Set 함수

  set time(DateTime input) {
    _time = input;
  }

  set temp(int input) {
    _temp = input;
  }

  set sTemp(int input) {
    _sTemp = input;
  }

  set sky(String input) {
    _sky = input;
  }

  set rainRate(int input) {
    _rainRate = input;
  }

  set windSpeed(double input) {
    _windSpeed = input;
  }

  // 해당 객체 업데이트(갱신)
  void initForecast(DateTime newTime, int newTemp, int newSTemp, String newSky,
      int newRainRate, double newWindSpeed) {
    time = newTime;
    temp = newTemp;
    sky = newSky;
    rainRate = newRainRate;
    sTemp = newSTemp;
    windSpeed = newWindSpeed;
  }
}
