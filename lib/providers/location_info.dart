import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Location extends ChangeNotifier {
  static List _location = [];
  static String _cur = "";
  String get cur => _cur;
  List get location => _location;
  var prefs;

  set cur(String new_) {
    _cur = new_;
    notifyListeners();
  }

  set location(List new_) {
    _location.add(new_.last);
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

  void save_all() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'my_location', json.encode({"selected": cur, "location": location}));
  }

  void del_loc(String one) {
    _location.removeWhere((element) => element['name'] == one);
    save_all();
  }
}
