import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweater/module/location.dart';

class LocationProvider extends ChangeNotifier {
  List<Location> _locationList = [];
  late Location _current;
  Location get current => _current;
  List get locationList => _locationList;

  var prefs;

  set current(Location _newLocation) {
    if (_locationList
            .where((location) => location.address == _newLocation.address)
            .length ==
        1) _current = _newLocation;
    // notifyListeners();
  }

  LocationProvider() {}

  void addLocation(Location newLocation) {
    _locationList.add(newLocation);
  }

  Future<bool> initLocation() async {
    prefs = await SharedPreferences.getInstance();
    String myLocationJson = prefs.getString('my_location') ?? "";
    if (myLocationJson != "") {
      Map myLocation = json.decode(myLocationJson);
      _locationList = myLocation['location'].map<Location>((locationJson) {
        return Location.fromJson(locationJson);
      }).toList();
      _current = _locationList.firstWhere((location) {
        return location.address == myLocation['selected'];
      });
    } else {
      _locationList = [
        Location("서울특별시 동작구", {'X': 59, "Y": 125})
      ];
      _current = _locationList[0];
    }
    notifyListeners();
    return true;
  }

  void saveAll() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('my_location',
        json.encode({"selected": _current.name, "location": _locationList}));
  }

  void deleteLocation(Location targetLocation) {
    _locationList
        .removeWhere((location) => location.name == targetLocation.name);
    saveAll();
    notifyListeners();
  }
}
