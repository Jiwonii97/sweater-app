// 테스트용 함수

import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import "dart:math";
import 'package:flutter/services.dart' show rootBundle;

// Weather 객체 클래스
class Weather {
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
  List<HourForecast> get forecastList => _forecastList;
  static const int predictMax = 12; // 전체 객체의 개수 이자 날씨를 구할 시간의 수
  // API Key값
  late String _myKey = '';

  //
  final String _requestHost = "apis.data.go.kr";
  final String _requestPath =
      "/1360000/VilageFcstInfoService_2.0/getVilageFcst";

  Weather() {
    for (var i = 0; i < predictMax; i++) {
      _forecastList.add(HourForecast());
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
    return res.toStringAsFixed(1);
  }

  Future<List<HourForecast>> updateWeather(
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
      var getTime = predictMax; // 몇 시간의 정보를 가져올 것인가
      final url = Uri.https(_requestHost, _requestPath, {
        "serviceKey": _myKey,
        "pageNo": "1",
        "numOfRows": (getTime * 12).toString(),
        "dataType": "JSON",
        "base_date": basedate,
        "base_time": basetime,
        "nx": nx,
        "ny": ny
      });
      var response = await http.get(url);
      // print(url);
      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }

      final List itemList = (convert.jsonDecode(response.body))['response']
          ['body']['items']['item'];
      final Iterable tempList = itemList.where((el) => el['category'] == 'TMP');
      final Iterable skyList = itemList.where((el) => el['category'] == 'SKY');
      final Iterable rainList = itemList.where((el) => el['category'] == 'PTY');
      final Iterable rainRateList =
          itemList.where((el) => el['category'] == 'POP');
      final Iterable windSpeedList =
          itemList.where((el) => el['category'] == 'WSD');

      final Iterable dateList = windSpeedList.map((el) => el['fcstDate']);
      final Iterable timeList = windSpeedList.map((el) => el['fcstTime']);
      for (var i = 0; i < predictMax; i++) {
        forecastList[i].initHourForecast(
            dateList.elementAt(i), // 날짜
            timeList.elementAt(i), // 시간
            tempList.elementAt(i)['fcstValue'], // 온도
            makeSTemp(int.parse(tempList.elementAt(i)['fcstValue']),
                double.parse(windSpeedList.elementAt(i)['fcstValue'])), // 체감 온도
            makeSky(skyList.elementAt(i)['fcstValue'],
                rainList.elementAt(i)['fcstValue']), // 하늘 상태(구름 상태)
            int.parse(rainRateList.elementAt(i)['fcstValue']), // 강수 확률
            windSpeedList.elementAt(i)['fcstValue']); // 풍속
      }
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }

    return forecastList;
  }
}

class HourForecast {
  // 초기값 설정
  String _date = "19700101";
  String _time = "9999"; // 시간
  String _temp = "999"; // 기온
  String _sTemp = "999"; // 체감 온도
  String _sky = ""; // 구름 상태(1,3,4) - 맑음(1), 구름많음(3), 흐림(4)
  int _rainRate = -1; // 강수 확률
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

  set rainRate(int input) {
    _rainRate = input;
  }

  set windSpeed(String input) {
    _windSpeed = input;
  }

  void initHourForecast(String newDate, String newTime, String newTemp,
      String newsTemp, String newSky, int newRainRate, String newWindSpeed) {
    date = newDate;
    time = newTime;
    temp = newTemp;
    sky = newSky;
    rainRate = newRainRate;
    sTemp = newsTemp;
    windSpeed = newWindSpeed;
  }

  void testPrint() {
    print("날짜 : $_date");
    print("시간 : $_time");
    print("기온 : $_temp");
    print("체감 온도 : $_sTemp");
    print("구름 상태 : $_sky");
    print("강수 확률 : $_rainRate");
    print("풍속 : $_windSpeed");
  }
}

// Future<Weather> getWeatherAPI() async {
void main() async {
  Weather wt = Weather();
  var result = await wt.updateWeather("20220405", "1100", "59", "125");
  print(result);

  print(wt.forecastList[0]._date);
  print(wt.forecastList.length);
  print("-------------------------\n\n");

  wt.forecastList[0].testPrint();

  return;
}
