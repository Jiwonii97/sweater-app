import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:sweater/providers/weather.dart';
import 'package:sweater/module/cloth.dart';
import 'package:http/http.dart' as http;

class CoordiProvider with ChangeNotifier {
  List<Coordi> _coordiList = [];
  Coordi _coordi = Coordi("", [], [], 0); //String url, List<dynamic> clothes
  Cloth _outer = Cloth("", "", "", [], "");
  Cloth _topCloth = Cloth("", "", "", [], "");
  Cloth _bottomCloth = Cloth("", "", "", [], "");

  int _coordiIdx = 0;
  bool _isReadyCoordiState = false;

  Coordi get coordi => _coordi;
  Cloth get outer => _outer;
  Cloth get topCloth => _topCloth;
  Cloth get bottomCloth => _bottomCloth;
  List<Coordi> get coordiList => _coordiList;
  int get coordiIdx => _coordiIdx;
  bool get isReadyCoordiState => _isReadyCoordiState;

  set setCoordiLists(List<Coordi> input) {
    _coordiList = input;
  }

  set setCoordi(Coordi input) {
    _coordi = Coordi(input.url, input.items, input.temperature, input.gender);
  }

  set setOuter(Cloth input) {
    _outer = Cloth(input.majorCategory, input.minorCategory, input.color,
        input.features, input.thickness);
  }

  set setTopCloth(Cloth input) {
    _topCloth = Cloth(input.majorCategory, input.minorCategory, input.color,
        input.features, input.thickness);
  }

  set setBottomCloth(Cloth input) {
    _bottomCloth = Cloth(input.majorCategory, input.minorCategory, input.color,
        input.features, input.thickness);
  }

  set setInitCoordiState(bool input) {
    _isReadyCoordiState = input;
  }

  void addCoordiListElement(Coordi input) {
    coordiList.add(input);
  }

  void clearCoordiList() {
    coordiList.clear();
  }

  void nextCoordi() {
    _coordiIdx++;
    if (_coordiIdx >= coordiList.length) _coordiIdx = 0;
    notifyListeners();
  }

  void prevCoordi() {
    _coordiIdx--;
    if (_coordiIdx < 0) {
      _coordiIdx = coordiList.length - 1;
    }
    notifyListeners();
  }

  Future<String> requestCoordis(
      List<HourForecast> forecastList, int forecastIdx, int userGender) async {
    Uri uri = Uri.parse(
        "https://us-central1-sweather-46fbf.cloudfunctions.net/api/coordi/recommand?gender=$userGender&stemp=${forecastList[forecastIdx].getSTemp}&isRain=${forecastList[forecastIdx].getRainRate == '0' ? false : true}&isSnow=${forecastList[forecastIdx].getRainRate == '0' ? false : true}&windSpeed=${forecastList[forecastIdx].getWindSpeed}");
    var response = await http.get(uri);
    return response.body;
  }

  // Future<String> requestDummy(
  //     List<HourForecast> forecastList, int forecastIdx, int userGender) async {
  //   print("!!");
  //   Uri uri = Uri.parse(
  //       "https://us-central1-sweather-46fbf.cloudfunctions.net/api/coordi/recommand?gender=1&stemp=5&isRain=false&isSnow=false&windSpeed=0");
  //   var response = await http.get(uri);
  //   return response.body;
  // }

  void initCoordiList(
      List<HourForecast> forecastList, int forecastIdx, int userGender) async {
    String result = await requestCoordis(forecastList, forecastIdx, userGender);
    setInitCoordiState = true; //코디 요청 완료 플래그

    List<dynamic> coordiLists = convert.jsonDecode(result);
    for (int i = 0; i < coordiLists.length; i++) {
      //코디 리스트 생성
      addCoordiListElement(Coordi(
          coordiLists[i]['url'],
          coordiLists[i]['items'],
          coordiLists[i]['temperature'],
          coordiLists[i]['gender']));
    }
    notifyListeners();
  }

  void requestCoordiList(
      List<HourForecast> forecastList, int forecastIdx, int userGender) async {
    _coordiIdx = 0;
    String result = await requestCoordis(forecastList, forecastIdx, userGender);
    // String result = await requestDummy(forecastList, forecastIdx, userGender);
    List<dynamic> coordiLists = convert.jsonDecode(result);
    clearCoordiList();

    for (int i = 0; i < coordiLists.length; i++) {
      //코디 리스트 생성
      addCoordiListElement(Coordi(
          coordiLists[i]['url'],
          coordiLists[i]['items'],
          coordiLists[i]['temperature'],
          coordiLists[i]['gender']));
    }
    notifyListeners();
  }

  String getOuter() {
    setCoordi = coordiList[coordiIdx];
    if (coordiList[coordiIdx].items.length == 2) return "";

    setOuter = Cloth.fromJson(coordi.items[0]);
    String result = outer.getClothInfo();
    return result;
  }

  String getTopCloth() {
    setCoordi = coordiList[coordiIdx];
    int itemIdx = 0;
    for (int i = 0; i < coordiList[coordiIdx].items.length; i++) {
      if (coordiList[coordiIdx].items[i]['major'] == 'top') {
        itemIdx = i;
        break;
      }
    }
    setTopCloth = Cloth.fromJson(coordi.items[itemIdx]);
    String result = topCloth.getClothInfo();
    return result;
  }

  String getBottomCloth() {
    setCoordi = coordiList[coordiIdx];
    int itemIdx = 0;
    for (int i = 0; i < coordiList[coordiIdx].items.length; i++) {
      if (coordiList[coordiIdx].items[i]['major'] == 'bottom') {
        itemIdx = i;
        break;
      }
    }
    setBottomCloth = Cloth.fromJson(coordi.items[itemIdx]);
    String result = bottomCloth.getClothInfo();
    return result;
  }
}
