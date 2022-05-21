import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:sweater/api/fetch_weather.dart';
import 'package:sweater/module/cloth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweater/api/fetch_coordi_list.dart';
import 'package:sweater/module/constitution.dart';
import 'package:sweater/module/coordi.dart';
import 'package:sweater/module/forecast.dart';
import 'package:sweater/module/gender.dart';
import 'package:sweater/module/user.dart';
import 'package:sweater/my_http_overrides.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

main() async {
  dotenv.testLoad(fileInput: File('test/.env').readAsStringSync());

  HttpOverrides.global = MyHttpOverrides();
  test('fetch_weather 통신 테스트', () async {
    int predictMax = 12;
    int nx = 61, ny = 124;
    DateTime now = DateTime.now();
    String key = dotenv.env['WEATHER_API_KEY'] ?? '';
    List<dynamic>? response = await fetchWeather(nx, ny, now, predictMax, key);
    expect(response.runtimeType != Null, true);
    if (response != null) {
      expect(response.length, 12);
    }
  });
}
