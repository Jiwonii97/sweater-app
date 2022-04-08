import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Location extends ChangeNotifier {
  static List _location = [];
  static String _cur = "";
  String get cur => _cur;
  List get location => _location;
  int get X => getX();
  int get Y => getY();
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

  int getX() {
    for (var loc in _location) {
      if (loc['name'] == _cur) return loc['X'];
    }
    return 0;
  }

  int getY() {
    for (var loc in _location) {
      if (loc['name'] == _cur) return loc['Y'];
    }
    return 0;
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
