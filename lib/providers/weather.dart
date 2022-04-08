import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import "dart:math"; // 체감 온도 계산을 위한 연산 라이브러리
import 'package:intl/intl.dart'; // 날짜 계산을 위한 라이브러리

// Weather 객체 클래스
class Weather extends ChangeNotifier {
  // 구름 상태 인덱스
  static const _sunny = "1";
  static const _cloudiness = "3";
  static const _cloudy = "4";

  // 강수 형태 인덱스
  static const _rainNo = "0";
  static const _rainRain = "1";
  static const _rainRainAndSnow = "2";
  static const _rainSnow = "3";
  static const _rainDrop = "4";

  final List<HourForecast> _forecastList = [];
  List<HourForecast> get forecastList => _forecastList; // get 필드
  static const int predictMax = 12; // 객체 12개 생성으로 인한 12시간의 날씨 데이터 보유

  // API Key값
  late String _myKey = '';
  bool flagApi = false; // 키값을 1회만 불러오게 하기 위한 flag

  // 해당 API 주소
  final String _requestHost = "apis.data.go.kr";
  final String _requestPath =
      "/1360000/VilageFcstInfoService_2.0/getVilageFcst";

  // 생성자
  Weather() {
    for (var i = 0; i < predictMax; i++) {
      forecastList.add(HourForecast());
    }
  }

  // JSON을 통해 키값 불러오기
  Future<bool> initKey() async {
    try {
      _myKey = convert.json.decode(
          await rootBundle.loadString('assets/weather-api.json'))['_mykey'];
      return true;
    } catch (e) {
      return false;
    }
  }

  // 기상 정보(날씨 상태) 설정 함수
  String makeSky(String sky, String rain) {
    String res = "";
    // 오늘 비 예보가 없는 경우, 구름 상태에 따라 기상 정보 제공
    if (rain.compareTo(_rainNo) == 0) {
      switch (sky) {
        case _sunny:
          res = "맑음";
          break;
        case _cloudiness:
          res = "구름 많음";
          break;
        case _cloudy:
          res = "흐림";
          break;
      }
    } else {
      switch (rain) {
        case _rainRain:
          res = "비";
          break;
        case _rainRainAndSnow:
          res = "비/눈";
          break;
        case _rainSnow:
          res = "눈";
          break;
        case _rainDrop:
          res = "소나기";
          break;
      }
    }
    return res;
  }

  // 체감 온도 계산 함수
  String makeSTemp(int temp, double windSpeed) {
    var T = temp;
    var V = pow(windSpeed * 3.6, 0.16);

    // 체감온도 계산
    var res = 13.12 + (0.6215 * T) - (11.37 * V) + (0.3965 * V * T);
    return res.round().toString();
  }

  // API를 받아서 해당 날씨 데이터를 Weather 객체에 업데이트
  void updateWeather(String nx, String ny) async {
    /*
    String basedate   // 기준 날짜    ex) 19700101
    String basetime   // 기준 시간 값     ex) 1200
    String nx   // 기준 위치 X좌표    ex) 59
    String ny   // 기준 위치 Y좌표    ex) 125
    */

    if ((_myKey == '') & (flagApi == false)) {
      // api 키값을 제대로 받아오면 해당 flag를 true로 바꿔 1회만 실행되게 함
      flagApi = await initKey();
    }

    // 현재 시간(now) 기준, 1시간전 시간(anHourBefore) 구하기
    var now = DateTime.now(); //현재일자
    var anHourBefore = now.subtract(const Duration(hours: 1));

    // 날짜 데이터를 받아서 원하는 basetime, basedate 만들기
    String basedate = DateFormat("yyyyMMdd").format(anHourBefore);
    String baseHour = DateFormat("HH").format(anHourBefore);
    String curHour = DateFormat("HH").format(now);

    // 원하는 시간값을 불러올 수 있도록 계산
    var predHour = (((int.parse(baseHour) - 2) ~/ 3) * 3) + 2;
    String basetime = predHour.toString().padLeft(2, "0") + "30";

    try {
      var getTime = predictMax; // 몇 시간의 정보를 가져올 것인가

      // url 변환
      final url = Uri.https(_requestHost, _requestPath, {
        "serviceKey": _myKey,
        "pageNo": "1",
        "numOfRows": ((getTime + 2) * 12).toString(),
        "dataType": "JSON",
        "base_date": basedate,
        "base_time": basetime,
        "nx": nx,
        "ny": ny
      });
      final response = await http.get(url); // http 호출
      // print(url);

      // http 호출이 안되면 예외 처리
      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }

      // 전체 item 항목을 list로 바꾸고, 해당 카테고리에 맞는 정보만 따로 추출
      final List itemList = (convert.jsonDecode(response.body))['response']
          ['body']['items']['item'];

      // 순서대로 온도, 기상상태, 강수상태, 강수확률, 풍속, 날짜, 시간 데이터를 가져온다
      final Iterable tempList = itemList.where((el) => el['category'] == 'TMP');
      final Iterable skyList = itemList.where((el) => el['category'] == 'SKY');
      final Iterable rainList = itemList.where((el) => el['category'] == 'PTY');
      final Iterable rainRateList =
          itemList.where((el) => el['category'] == 'POP');
      final Iterable windSpeedList =
          itemList.where((el) => el['category'] == 'WSD');

      final Iterable dateList = windSpeedList.map((el) => el['fcstDate']);
      final Iterable timeList = windSpeedList.map((el) => el['fcstTime']);

      int tmp = 0; // 기준 시간으로 부터 차이 나는 시간을 구할때 사용하는 임시 변수
      int idx = 0; // 인덱스 부여용 변수

      // 데이터 업데이트
      for (var i = 0; i < (predictMax + 2); i++) {
        // 12시간 데이터를 전부 받으면 데이터 업데이트 작업을 종료
        if (idx == predictMax) {
          break;
        }

        // 기준 시간과 얼마나 차이나는지 나머지 연산을 통한 계산 진행
        if ((predHour - tmp) % 3 != 0) {
          tmp++;
          continue;
        } else {
          // 조건에 맞으면 클래스 리스트에 값을 갱신
          forecastList[idx].initHourForecast(
              dateList.elementAt(idx), // 날짜
              timeList.elementAt(idx), // 시간
              tempList.elementAt(idx)['fcstValue'], // 온도
              makeSTemp(
                  int.parse(tempList.elementAt(idx)['fcstValue']),
                  double.parse(
                      windSpeedList.elementAt(idx)['fcstValue'])), // 체감 온도
              makeSky(skyList.elementAt(idx)['fcstValue'],
                  rainList.elementAt(idx)['fcstValue']), // 하늘 상태(구름 상태)
              rainRateList.elementAt(idx)['fcstValue'], // 강수 확률
              windSpeedList.elementAt(idx)['fcstValue']); // 풍속
          idx++; // 다음 인덱스
        }
      }
      notifyListeners();
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    } catch (e) {
      print(e);
    }
  }
}

// 시간별 날씨 정보를 담고 있는 객체
class HourForecast {
  // 초기값(Default) 설정
  String _date = "19700101";
  String _time = "9999"; // 시간
  String _temp = "999"; // 기온
  String _sTemp = "999"; // 체감 온도
  String _sky = ""; // 구름 상태 - 맑음, 구름많음, 흐림, 비, 비/눈, 눈, 소나기
  String _rainRate = "-1"; // 강수 확률
  String _windSpeed = "-1"; // 풍속

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

  set sTemp(String input) {
    _sTemp = input;
  }

  set sky(String input) {
    _sky = input;
  }

  set rainRate(String input) {
    _rainRate = input;
  }

  set windSpeed(String input) {
    _windSpeed = input;
  }

  // 해당 객체 업데이트(갱신)
  void initHourForecast(String newDate, String newTime, String newTemp,
      String newsTemp, String newSky, String newRainRate, String newWindSpeed) {
    date = newDate;
    time = newTime;
    temp = newTemp;
    sky = newSky;
    rainRate = newRainRate;
    sTemp = newsTemp;
    windSpeed = newWindSpeed;
  }

  // void testPrint() {
  //   print("날짜 : $_date");
  //   print("시간 : $_time");
  //   print("기온 : $_temp");
  //   print("체감 온도 : $_sTemp");
  //   print("구름 상태 : $_sky");
  //   print("강수 확률 : $_rainRate");
  //   print("풍속 : $_windSpeed");
  // }
}
