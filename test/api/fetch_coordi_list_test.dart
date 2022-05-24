import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:sweater/module/cloth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweater/api/fetch_coordi_list.dart';
import 'package:sweater/module/constitution.dart';
import 'package:sweater/module/coordi.dart';
import 'package:sweater/module/forecast.dart';
import 'package:sweater/module/gender.dart';
import 'package:sweater/module/user.dart';
import 'package:sweater/providers/weather_provider.dart';
import 'package:sweater/my_http_overrides.dart';

/* Cloth의 속성
  final String _majorCategory;
  final String _minorCategory;
  final String _color; // white,black,navy 등
  final List<dynamic> _features;
  final String _thickness; // "","thin","thick",
*/
main() {
  HttpOverrides.global = MyHttpOverrides();
  Forecast currentForecast = Forecast();
  DateTime specificDate =
      DateFormat("yyyy-MM-dd HH:mm").parse("2022-05-17 04:24");
  currentForecast.initForecast(specificDate, 26, 28, "맑음", 0, 2.8);
  User user = User(Gender.man, Constitution.feelCold);
  Map<String, List<String>> clothFilter = {
    "outer": [],
    "top": [],
    "bottom": [],
    "one_piece": []
  };
  int key = 13;
  int index = 0;
  test('fetch_coordi_list pagenation 통신 테스트', () async {
    var response =
        await fetchCoordiList(currentForecast, user, clothFilter, key, index);
    expect(response['index'], 0);
    expect(response['key'], 13);
    if (response['coordis'].length < 20) {
      expect(response['maxIndex'], 0);
    } else {
      expect(response['coorids'].length, 20);
      expect(response['maxIndex'] > 0, true);
    }
    for (int i = 0; i < response.length; i++) {
      Coordi coordi = Coordi(
          response[i]['url'],
          response[i]['items'].map<Cloth>((item) {
            return Cloth(
                item['major'], item['minor'], item['color'], item['full_name']);
          }).toList(),
          response[i]['style']);

      expect(coordi.getCoordiInfo().isNotEmpty, true);
      expect(coordi.getIllustUrl().isNotEmpty, true);
      expect(coordi.style.isNotEmpty, true);
    }
  });
  test('fetch_coordi_list pagenation 최초 통신 테스트', () async {
    //최초 통신에는 key,index가 없이 들어와야함 혹은 key= -1, index = 0 으로 보내야함
    var response = await fetchCoordiList(currentForecast, user, clothFilter);
    expect(response['index'], 0);
    if (response['coordis'].length == 0) {
      expect(response['key'], -1);
      expect(response['maxIndex'], 0);
    } else if (response['coordis'].length < 20) {
      expect(response['key'] > 0, true);
      expect(response['maxIndex'], 0);
    } else {
      expect(response['coorids'].length, 20);
      expect(response['key'] > 0, true);
      expect(response['maxIndex'] > 0, true);
    }

    for (int i = 0; i < response['coordis'].length; i++) {
      Coordi coordi = Coordi(
          response['coordis'][i]['url'],
          response['coordis'][i]['items'].map<Cloth>((item) {
            return Cloth(
                item['major'], item['minor'], item['color'], item['full_name']);
          }).toList(),
          response['coordis'][i]['style']);

      expect(coordi.getCoordiInfo().isNotEmpty, true);
      expect(coordi.getIllustUrl().isNotEmpty, true);
      expect(coordi.style.isNotEmpty, true);
    }
  });
}
