import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
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

main() {
  dotenv.testLoad(fileInput: File('test/.env').readAsStringSync());
  WeatherProvider weatherProvider = WeatherProvider();
  test('WeatherProvider 생성', () async {
    expect(weatherProvider.forecastList.length, 12);
  });
  test('WeatherProvider 날씨 불러오기', () async {
    bool isRequestSuccess = await weatherProvider.updateWeather(61, 124);
    expect(isRequestSuccess, true);
    expect(weatherProvider.forecastList.length, 12);
  });
}
