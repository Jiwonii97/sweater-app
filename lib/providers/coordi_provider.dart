import 'package:flutter/material.dart';
import 'package:sweater/module/forecast.dart';
import 'package:sweater/api/fetch_filter_list.dart';
import 'package:sweater/module/user.dart';
import 'dart:convert' as convert;
import 'package:sweater/providers/weather_provider.dart';
import 'package:sweater/module/cloth.dart';
import 'package:sweater/module/coordi.dart';
import 'package:async/async.dart';
import 'package:sweater/api/fetch_coordi_list.dart';

class CoordiProvider with ChangeNotifier {
  CancelableOperation? _coordiListFuture;

  List<Coordi> coordiList = [];
  Coordi _coordi = Coordi("", [], "");
  bool isReadyCoordiState = false;
  bool _isUpdateCoordiState = false;
  String filterResponse = "";
  Map<String, List<String>> filterList = {};
  Map<String, List<String>> _pickedCategory = {
    "outer": [],
    "top": [],
    "bottom": [],
    "one_piece": []
  };

  Coordi get coordi => _coordi;
  bool get isUpdateCoordiState => _isUpdateCoordiState;
  Map<String, List<String>> get pickedCategory => _pickedCategory;

  set coordi(Coordi input) {
    _coordi = Coordi(input.url, input.clothes, input.style);
  }

  set isUpdateCoordiState(bool input) {
    _isUpdateCoordiState = input;
    notifyListeners();
  }

  set pickedCategory(Map<String, List<String>> input) {
    _pickedCategory = input;
    notifyListeners();
  }

  Future<bool> requestCoordiListWithFiltering(
      Forecast selectedForecast, User user) async {
    isUpdateCoordiState = false;
    coordiList.clear();
    List<dynamic> filteredCoordiList =
        await fetchCoordiList(selectedForecast, user, pickedCategory);
    for (int i = 0; i < filteredCoordiList.length; i++) {
      coordiList.add(
        Coordi(
            filteredCoordiList[i]['url'],
            filteredCoordiList[i]['items'].map<Cloth>((item) {
              return Cloth(item['major'], item['minor'], item['color'],
                  item['full_name']);
            }).toList(),
            filteredCoordiList[i]['style']),
      );
    }
    isUpdateCoordiState = true;
    notifyListeners();
    return true;
  }

  Future<bool> requestCoordiList(Forecast selectedForecast, User user) async {
    if (_coordiListFuture != null) {
      _coordiListFuture?.cancel();
    }
    _coordiListFuture = CancelableOperation.fromFuture(
      fetchCoordiList(selectedForecast, user, pickedCategory),
    );
    isUpdateCoordiState = false;
    filterResponse = await fetchFilterList(selectedForecast, user);
    filterList = convert.jsonDecode(filterResponse);

    final responseCoordiLists = await _coordiListFuture?.value;
    if (responseCoordiLists == null) {
      notifyListeners();
      return false;
    } else {
      coordiList.clear();
      for (int i = 0; i < responseCoordiLists.length; i++) {
        //코디 리스트 생성
        coordiList.add(
          Coordi(
              responseCoordiLists[i]['url'],
              responseCoordiLists[i]['items'].map<Cloth>((item) {
                return Cloth(item['major'], item['minor'], item['color'],
                    item['full_name']);
              }).toList(),
              responseCoordiLists[i]['style']),
        );
      }
      isReadyCoordiState = true;
      isUpdateCoordiState = true;
      notifyListeners();
      return true;
    }
  }

  clearPickedCategory() {
    pickedCategory['outer']!.clear();
    pickedCategory['top']!.clear();
    pickedCategory['bottom']!.clear();
    pickedCategory['one_piece']!.clear();

    notifyListeners();
  }
}
