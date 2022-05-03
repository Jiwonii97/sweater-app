import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweater/module/error_type.dart';
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

  int addLocation(Location newLocation) {
    bool isDuplicated = _locationList.indexWhere(
            (location) => location.address == newLocation.address) >=
        0;
    if (!isDuplicated) {
      _locationList.add(newLocation);
      notifyListeners();
      return ErrorType.successCode;
    } else {
      return ErrorType.duplicationErrorCode;
    }
  }

  Future<int> initLocation() async {
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
        Location("서울특별시 동작구 상도제1동", {'X': 59, "Y": 125})
      ];
      _current = _locationList[0];
    }
    notifyListeners();
    return ErrorType.successCode;
  }

  void saveAll() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'my_location',
        json.encode({
          "selected": _current.address,
          "location":
              _locationList.map((location) => location.toJson()).toList()
        }));
  }

  void deleteLocation(Location targetLocation) {
    _locationList
        .removeWhere((location) => location.name == targetLocation.name);
    saveAll();
    notifyListeners();
  }
}
