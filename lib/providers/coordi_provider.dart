import 'package:flutter/material.dart';
import 'package:sweater/module/forecast.dart';
import 'package:sweater/module/user.dart';
import 'dart:convert' as convert;
import 'package:sweater/providers/weather_provider.dart';
import 'package:sweater/module/cloth.dart';
import 'package:sweater/module/coordi.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:sweater/api/fetch_coordi_list.dart';

class CoordiProvider with ChangeNotifier {
  CancelableOperation? _coordiListFuture;

  List<Coordi> coordiList = [];
  Coordi _coordi = Coordi("", [], "");
  int coordiIdx = 0;
  bool isReadyCoordiState = false;
  bool _isUpdateCoordiState = false;

  Coordi get coordi => _coordi;
  bool get isUpdateCoordiState => _isUpdateCoordiState;

  set coordi(Coordi input) {
    _coordi = Coordi(input.url, input.clothes, input.style);
  }

  set isUpdateCoordiState(bool input) {
    _isUpdateCoordiState = input;
    notifyListeners();
  }

  void nextCoordi() {
    coordiIdx++;
    if (coordiIdx >= coordiList.length) coordiIdx = 0;
    notifyListeners();
  }

  void prevCoordi() {
    coordiIdx--;
    if (coordiIdx < 0) {
      coordiIdx = coordiList.length - 1;
    }
    notifyListeners();
  }

  Future<bool> requestCoordiList(Forecast selectedForecast, User user) async {
    if (_coordiListFuture != null) {
      _coordiListFuture?.cancel();
    }
    _coordiListFuture = CancelableOperation.fromFuture(
      fetchCoordiList(selectedForecast, user),
    );
    coordiIdx = 0;
    isUpdateCoordiState = false;
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
}
