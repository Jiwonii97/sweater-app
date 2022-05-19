import 'package:sweater/module/constitution.dart';
import 'package:sweater/module/error_type.dart';
import 'package:sweater/module/forecast.dart';
import 'package:sweater/module/user.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<dynamic>> fetchCoordiList(
    Forecast selectedForecast, User user) async {
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
    String host =
        "https://us-central1-sweather-46fbf.cloudfunctions.net/api/coordi/recommand?";
    host += "gender=${user.gender}&";
    host += "stemp=${userCustomedTemp.toString()}&";
    host += "isRain=${selectedForecast.sky == '비' ? true : false}&";
    host += "isSnow=${selectedForecast.sky == '눈' ? true : false}&";
    host += "windSpeed=${selectedForecast.windSpeed}";

    Uri uri = Uri.parse(host);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception();
    }
  } catch (e) {
    return [];
  }
}
