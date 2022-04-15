import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';
import 'package:sweater/providers/weather.dart';
import 'package:sweater/providers/user_info.dart';

import 'package:http/http.dart' as http;

class Coordi {
  String _url;
  // List<Cloth> _clothes;
  List<dynamic> _clothes;

  Coordi(this._url, this._clothes);

  String get url => _url;
  List<dynamic> get clothes => _clothes;
  Coordi.fromJson(Map<String, dynamic> json)
      : _url = json['url'],
        _clothes = json['items'];

  List<String> getCoordiInfo() {
    return ['흰 크롭 반팔티'];
  }

  getIllustUrl() {}
}

class Cloth {
  // String _mainCategory;
  // String _subCategory;
  String _category;
  Color _color;
  List<String> _features;

  // Cloth(this._mainCategory, this._subCategory, this._color, this._features);
  Cloth(this._category, this._color, this._features);

  String get category => _category;
  Color get color => _color;
  List<String> get features => _features;

  String getClothInfo() {
    return '흰 크롭 반팔티';
  }
}

class CoordiProvider with ChangeNotifier {
  Coordi _coordi = Coordi("", []); //String url, List<dynamic> clothes
  Cloth _cloth = Cloth("", Color(0x0000), []);
  String _coordiLists = "";

  int _coordiIdx = 0;
  bool _initCoordiState = false;

  Coordi get coordi => _coordi;
  Cloth get cloth => _cloth;
  String get coordiLists => _coordiLists;
  int get coordiIdx => _coordiIdx;
  bool get initCoordiState => _initCoordiState;

  set setCoordi(Coordi input) {
    _coordi = Coordi(input._url, input._clothes);
  }

  set setCoordiLists(String input) {
    _coordiLists = input;
  }

  set setInitCoordiState(bool input) {
    _initCoordiState = input;
  }

  Future<String> requestCoordis(
      List<HourForecast> forecastList, int userGender) async {
    Uri uri = Uri.parse(
        // "https://us-central1-sweather-46fbf.cloudfunctions.net/api/coordi/recommand?gender=$userGender&stemp=${forecastList[0].getSTemp}&isRain=${forecastList[0].getRainRate == '0' ? false : true}&isSnow=${forecastList[0].getRainRate == '0' ? false : true}&windSpeed=${forecastList[0].getWindSpeed}");
        "https://us-central1-sweather-46fbf.cloudfunctions.net/api/coordi/recommand?gender=1&stemp=14&isRain=false&isSnow=false&windSpeed=0");
    var response = await http.get(uri);
    return response.body;
  }

  void initCoordiList(List<HourForecast> forecastList, int userGender) async {
    String result = await requestCoordis(forecastList, userGender);
    print(result);
    setInitCoordiState = true;
    await Future.doWhile(() async {
      await Future.delayed(Duration(milliseconds: 100)); //100ms씩 대기
      if (initCoordiState) {
        return false;
      } else {
        return true;
      }
    });
    List<dynamic> coordiLists = convert.jsonDecode(result);
    setCoordi = Coordi.fromJson(coordiLists[0]);

    notifyListeners();
  }

  String getOuter() {
    return coordi.clothes[0]['category'];
  }

  String getTopCloth() {
    return coordi.clothes[1]['category'];
  }

  String getBottomCloth() {
    return coordi.clothes[2]['category'];
  }

  void nextCoordi() {
    _coordiIdx++;
    // if (_coordiIdx >= coordiLists!.docs.length) _coordiIdx = 0;
    notifyListeners();
  }

  void prevCoordi() {
    _coordiIdx--;
    if (_coordiIdx < 0) {
      // _coordiIdx = coordiLists!.docs.length - 1;
    }
    notifyListeners();
  }

  void goFirstCoordi() {
    _coordiIdx = 0;
    notifyListeners();
  }

  // void addCoordiList(QuerySnapshot? newCoordi) {
  //   coordiLists = newCoordi;
  //   notifyListeners();
  // }
}
