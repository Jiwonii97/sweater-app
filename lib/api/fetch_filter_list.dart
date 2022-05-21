import 'dart:convert';
import 'package:sweater/module/constitution.dart';
import 'package:sweater/module/user.dart';
import 'package:sweater/module/forecast.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:http/http.dart' as http;

Future<String> fetchFilterList(Forecast selectedForecast, User user) async {
  try {
    int userCustomedTemp = selectedForecast.sTemp;
    switch (user.constitution) {
      case Constitution.feelVeryHot: //더위 많이
        userCustomedTemp += 4;
        break;
      case Constitution.feelHot: //더위 조금
        userCustomedTemp += 2;
        break;
      case Constitution.feelCold: //추위 조금
        userCustomedTemp -= 2;
        break;
      case Constitution.feelVeryCold: //추위 많이
        userCustomedTemp -= 4;
        break;
      default:
        break;
    }
    Uri uri = Uri.parse(
        "https://us-central1-sweather-46fbf.cloudfunctions.net/api/coordi/list");
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    Object body = {
      "gender": user.gender,
      "stemp": userCustomedTemp,
      "isRain": selectedForecast.sky == '비' ? true : false,
      "isSnow": selectedForecast.sky == '눈' ? true : false,
      "windSpeed": selectedForecast.windSpeed
    };
    print(user.gender);
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception();
    }
  } catch (e) {
    return "";
  }
}
