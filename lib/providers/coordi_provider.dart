import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:sweater/providers/weather_provider.dart';
import 'package:sweater/module/cloth.dart';
import 'package:http/http.dart' as http;

class CoordiProvider with ChangeNotifier {
  List<Coordi> _coordiList = [];
  Coordi _coordi = Coordi("", [], [], 0);

  int _coordiIdx = 0;
  bool _isReadyCoordiState = false;

  Coordi get coordi => _coordi;

  List<Coordi> get coordiList => _coordiList;
  int get coordiIdx => _coordiIdx;
  bool get isReadyCoordiState => _isReadyCoordiState;

  set setCoordiLists(List<Coordi> input) {
    _coordiList = input;
  }

  set setCoordi(Coordi input) {
    _coordi = Coordi(input.url, input.clothes, input.temperature, input.gender);
  }

  set setReadyCoordiState(bool input) {
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

  Future<List<dynamic>> requestCoordis(List<HourForecast> forecastList,
      int forecastIdx, int userGender, int userConstitution) async {
    try {
      int currentSTemp = int.parse(forecastList[forecastIdx].getSTemp);
      switch (userConstitution) {
        case 2: //더위 많이
          currentSTemp += 4;
          break;
        case 1: //더위 조금
          currentSTemp += 2;
          break;
        case -1: //추위 조금
          currentSTemp -= 2;
          break;
        case -2: //추위 많이
          currentSTemp -= 4;
          break;
        default:
          break;
      }
      String requestSTemp = currentSTemp.toString();
      Uri uri = Uri.parse(
          "https://us-central1-sweather-46fbf.cloudfunctions.net/api/coordi/recommand?gender=$userGender&stemp=$requestSTemp&isRain=${forecastList[forecastIdx].getSky == '비' ? true : false}&isSnow=${forecastList[forecastIdx].getSky == '눈' ? true : false}&windSpeed=${forecastList[forecastIdx].getWindSpeed}");
      var response = await http.get(uri);
      return convert.jsonDecode(response.body);
    } catch (e) {
      return [];
    }
  }

  // Future<bool> initCoordiList(List<HourForecast> forecastList, int forecastIdx,
  //     int userGender, int userConstitution) async {
  //   List<dynamic> coordiLists = await requestCoordis(
  //       forecastList, forecastIdx, userGender, userConstitution);
  //   setReadyCoordiState = true; //코디 요청 완료 플래그
  //   if (coordiLists.length == 0) return false;
  //   for (int i = 0; i < coordiLists.length; i++) {
  //     //코디 리스트 생성
  //     addCoordiListElement(Coordi(
  //         coordiLists[i]['url'],
  //         coordiLists[i]['items'].map<Cloth>((item) {
  //           return Cloth(item['major'], item['minor'], item['color'],
  //               item['features'], item['thickness']);
  //         }).toList(),
  //         coordiLists[i]['temperature'],
  //         coordiLists[i]['gender']));
  //   }
  //   notifyListeners();
  //   return true;
  // }

  Future<bool> requestCoordiList(List<HourForecast> forecastList,
      int forecastIdx, int userGender, int userConstitution) async {
    _coordiIdx = 0;
    _isReadyCoordiState = false;
    List<dynamic> coordiLists = await requestCoordis(
        forecastList, forecastIdx, userGender, userConstitution);
    if (coordiLists.isEmpty) return false;
    clearCoordiList();
    for (int i = 0; i < coordiLists.length; i++) {
      //코디 리스트 생성
      addCoordiListElement(Coordi(
          coordiLists[i]['url'],
          coordiLists[i]['items'].map<Cloth>((item) {
            return Cloth(item['major'], item['minor'], item['color'],
                item['features'], item['thickness']);
          }).toList(),
          coordiLists[i]['temperature'],
          coordiLists[i]['gender']));
    }
    _isReadyCoordiState = true;
    notifyListeners();
    return true;
  }
}
