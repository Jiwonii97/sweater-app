import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import "dart:math"; // 체감 온도 계산을 위한 연산 라이브러리
import 'package:intl/intl.dart'; // 날짜 계산을 위한 라이브러리
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sweater/api/fetch_weather.dart';
import 'package:sweater/module/forecast.dart';

// Weather 객체 클래스
class WeatherProvider extends ChangeNotifier {
  bool initWeatherFlag = false;

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

  final List<Forecast> _forecastList = [];
  List<Forecast> get forecastList => _forecastList; // get 필드
  static const int predictMax = 24; // 객체 12개 생성으로 인한 24시간의 날씨 데이터 보유

  // API Key값
  late String _myKey = dotenv.env['WEATHER_API_KEY'] ?? '';
  bool flagApi = false; // 키값을 1회만 불러오게 하기 위한 flag

  // 해당 API 주소
  final String _requestHost = "apis.data.go.kr";
  final String _requestPath =
      "/1360000/VilageFcstInfoService_2.0/getVilageFcst";

  // 생성자
  WeatherProvider() {
    for (var i = 0; i < predictMax; i++) {
      forecastList.add(Forecast());
    }
  }

  // 현재 날씨 정보를 반환
  Forecast getCurrentWeather() {
    return _forecastList[0];
  }

  Forecast getSelectedWeather(int index) {
    if (index > _forecastList.length || index < 0) {
      return Forecast();
    } else {
      return _forecastList[index];
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
          res = "구름많음";
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
  int makeSTemp(int temp, double windSpeed) {
    var T = temp;
    var V = pow(windSpeed * 3.6, 0.16);

    // 체감온도 계산
    var res = 13.12 + (0.6215 * T) - (11.37 * V) + (0.3965 * V * T);
    return res.round();
  }

  // API를 받아서 해당 날씨 데이터를 Weather 객체에 업데이트
  Future<bool> updateWeather(int nx, int ny) async {
    /*
    String basedate   // 기준 날짜    ex) 19700101
    String basetime   // 기준 시간 값     ex) 1200
    String nx   // 기준 위치 X좌표    ex) 59
    String ny   // 기준 위치 Y좌표    ex) 125
    */
    // 현재 시간(now) 기준, 1시간전 시간(anHourBefore) 구하기
    // 30분으로 시간을 설정한 이유 : API 제공 시간(~이후)이 각 BaseTime +10분이기 때문이다
    try {
      List<dynamic>? itemList =
          await fetchWeather(nx, ny, DateTime.now(), predictMax, _myKey);
      if (itemList == null) throw Exception("날씨를 불러오지 못함");
      for (int i = 0; i < predictMax; i++) {
        forecastList[i].initForecast(
            itemList[i]["date"],
            itemList[i]["temp"], // 온도
            makeSTemp(itemList[i]["temp"], itemList[i]["windSpeed"]), // 체감 온도
            makeSky(itemList[i]["sky"], itemList[i]["rain"]), // 하늘 상태(구름 상태)
            itemList[i]["rainRate"], // 강수 확률
            itemList[i]["windSpeed"]); // 풍속
      }
      initWeatherFlag = true;
      notifyListeners();
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print(DateTime.now());
      print("Bad response format 👎");
    } catch (e) {
      print(e);
    }
    return initWeatherFlag;
  }
}
