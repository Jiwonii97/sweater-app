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
  Map<String, dynamic> filterList = {};
  Map<String, int> currentPage = {"key": -1, "index": 0};
  bool isAllLoaded = false;
  Map<String, List<String>> pickedCategory = {
    "outer": [],
    "top": [],
    "bottom": [],
    "one_piece": []
  };

  Coordi get coordi => _coordi;
  bool get isUpdateCoordiState => _isUpdateCoordiState;
  int get pageKey => currentPage['key'] ?? -1;
  int get pageIndex => currentPage['index'] ?? 0;

  set coordi(Coordi input) {
    _coordi = Coordi(input.url, input.clothes, input.style);
  }

  set isUpdateCoordiState(bool input) {
    _isUpdateCoordiState = input;
    notifyListeners();
  }

  Future<bool> requestCoordiList(Forecast selectedForecast, User user,
      {int pageKey = -1, int pageIndex = 0}) async {
    if (_coordiListFuture != null) {
      _coordiListFuture?.cancel();
    }
    if (pageIndex == 0) {
      coordiList.clear();
      isAllLoaded = false;
    }

    _coordiListFuture = CancelableOperation.fromFuture(
      fetchCoordiList(
          selectedForecast, user, pickedCategory, pageKey, pageIndex),
    );
    isUpdateCoordiState = false;
    filterResponse = await fetchFilterList(selectedForecast, user);
    filterList = convert.jsonDecode(filterResponse);

    final responseCoordiLists = await _coordiListFuture?.value;
    if (responseCoordiLists == null) {
      notifyListeners();
      return false;
    } else {
      // coordiList.clear();

      currentPage['key'] = responseCoordiLists['key'];
      currentPage['index'] = responseCoordiLists['index'];
      if (currentPage['index'] == responseCoordiLists['maxIndex'])
        isAllLoaded = true;
      for (int i = 0; i < responseCoordiLists['coordis'].length; i++) {
        //코디 리스트 생성
        coordiList.add(
          Coordi(
              responseCoordiLists['coordis'][i]['url'],
              responseCoordiLists['coordis'][i]['items'].map<Cloth>((item) {
                return Cloth(item['major'], item['minor'], item['color'],
                    item['full_name']);
              }).toList(),
              responseCoordiLists['coordis'][i]['style']),
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
