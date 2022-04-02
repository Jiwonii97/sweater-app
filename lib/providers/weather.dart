import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

// Weather 객체 클래스
class Weather extends ChangeNotifier {
  final List<HourForecast> _forecastList = [];
  List<HourForecast> get forecastList => _forecastList; // get 필드
  static const int predictMax = 6; // 객체는 6개 만들면 되니 예측 모델은 6개를 최대로 한다

  // API Key값
  late String _myKey = '';

  // 해당 API 주소
  final String _requestHost = "apis.data.go.kr";
  final String _requestPath =
      "/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst";

  // 생성자
  Weather() {
    for (var i = 0; i < predictMax; i++) {
      forecastList.add(HourForecast());
    }
  }

  Future<bool> initKey() async {
    try {
      _myKey = convert.json.decode(
          await rootBundle.loadString('assets/weather-api.json'))['_mykey'];
      return true;
    } catch (e) {
      return false;
    }
  }

  // API를 받아서 해당 날씨 데이터를 Weather 객체에 업데이트
  void updateWeather(
      String basedate, String basetime, String nx, String ny) async {
    /*
    String basedate // 기준 날짜
    String basetime // 기준 시간 값
    String nx // 기준 위치 X좌표
    String ny // 기준 위치 Y좌표
    */
    if (_myKey == '') {
      bool isSuccess = await initKey();
    }
    try {
      // url 변환
      final url = Uri.https(_requestHost, _requestPath, {
        "serviceKey": _myKey,
        "pageNo": "1",
        "numOfRows": "1000",
        "dataType": "JSON",
        "base_date": basedate,
        "base_time": basetime,
        "nx": nx,
        "ny": ny
      });
      final response = await http.get(url); // http 호출
      // http 호출이 안되면 예외 처리
      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }

      // 전체 item 항목을 list로 바꾸고, 해당 카테고리에 맞는 정보만 따로 추출
      final List itemList = (convert.jsonDecode(response.body))['response']
          ['body']['items']['item'];
      final Iterable tempList = itemList.where((el) => el['category'] == 'T1H');
      final Iterable skyList = itemList.where((el) => el['category'] == 'SKY');
      final Iterable rainList = itemList.where((el) => el['category'] == 'RN1');
      final Iterable rainRateList =
          itemList.where((el) => el['category'] == 'PTY');
      final Iterable windDirectionList =
          itemList.where((el) => el['category'] == 'VEC');
      final Iterable windSpeedList =
          itemList.where((el) => el['category'] == 'WSD');
      final Iterable dateList = windSpeedList.map((el) => el['fcstDate']);
      final Iterable timeList = windSpeedList.map((el) => el['fcstTime']);

      // 데이터 업데이트
      for (var i = 0; i < predictMax; i++) {
        forecastList[i].initHourForecast(
            dateList.elementAt(i),
            timeList.elementAt(i),
            tempList.elementAt(i)['fcstValue'],
            int.parse(skyList.elementAt(i)['fcstValue']),
            rainList.elementAt(i)['fcstValue'],
            int.parse(rainRateList.elementAt(i)['fcstValue']),
            int.parse(windDirectionList.elementAt(i)['fcstValue']),
            int.parse(windSpeedList.elementAt(i)['fcstValue']));
      }
      notifyListeners();
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }
  }
}

// 시간별 날씨 정보를 담고 있는 객체
class HourForecast {
  // 구름 상태 인덱스
  static const _sunny = 1;
  static const _cloudiness = 3;
  static const _cloudy = 4;

  // 강수 형태 인덱스
  static const _rainNo = 0;
  static const _rainRain = 1;
  static const _rainRainAndSnow = 2;
  static const _rainSnow = 3;
  static const _rainDropAndBizzard = 5;
  static const _rainBlizzard = 6;
  static const _snow = 7;

  // 초기값(Default) 설정
  String _date = "19700101";
  String _time = "9999"; // 시간
  String _temp = "99"; // 기온
  int _sky = 1; // 구름 상태(1,3,4) - 맑음(1), 구름많음(3), 흐림(4)
  String _rain = "-1"; // 강수량
  int _rainRate =
      0; // 강수 형태 - 없음(0), 비(1), 비/눈(2), 눈(3), 빗방울(5), 빗방울눈날림(6), 눈날림(7)
  int _windDirecton = -1;
  int _windSpeed = -1;

  // Set 함수
  set date(String input) {
    _date = input;
  }

  set time(String input) {
    _time = input;
  }

  set temp(String input) {
    _temp = input;
  }

  set sky(int input) {
    _sky = input;
  }

  set rain(String input) {
    _rain = input;
  }

  set rainRate(int input) {
    _rainRate = input;
  }

  set windDirection(int input) {
    _windDirecton = input;
  }

  set windSpeed(int input) {
    _windSpeed = input;
  }

  // 해당 객체 생성 함수
  void initHourForecast(
      String newDate,
      String newTime,
      String newTemp,
      int newSky,
      String newRain,
      int newRainRate,
      int newWindDirection,
      int newWindSpeed) {
    date = newDate;
    time = newTime;
    temp = newTemp;
    sky = newSky;
    rain = newRain;
    rainRate = newRainRate;
    windDirection = newWindDirection;
    windSpeed = newWindSpeed;
  }
}
