import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Location extends ChangeNotifier {
  static List _location = [];
  static String _cur = "";
  String get cur => _cur;
  String get currentDong => _cur.split(' ').last;
  List get location => _location;

  int get X => _location.length != 0 && _cur != ""
      ? _location.where((element) => element['name'] == _cur).single['X']
      : 0;

  int get Y => _location.length != 0 && _cur != ""
      ? _location.where((element) => element['name'] == _cur).single['Y']
      : 0;

  var prefs;

  set cur(String new_) {
    _cur = new_;
    notifyListeners();
  }

  set location(List new_) {
    bool dup = false;
    for (var address in _location) {
      if (address['name'] == new_.last['name']) dup = true;
    }
    if (!dup) _location.add(new_.last);
    notifyListeners();
  }

  Location() {
    initLocation();
  }

  void initLocation() async {
    prefs = await SharedPreferences.getInstance();
    String list = prefs.getString('my_location') ?? "";
    if (list != "") {
      _location = json.decode(list)['location'];
      _cur = json.decode(list)['selected'];
    }
    notifyListeners();
  }

  void saveAll() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'my_location', json.encode({"selected": cur, "location": location}));
  }

  void deleteLoc(String one) {
    _location.removeWhere((element) => element['name'] == one);
    saveAll();
    notifyListeners();
  }
}
