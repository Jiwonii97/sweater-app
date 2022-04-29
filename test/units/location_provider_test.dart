import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweater/module/error_type.dart';
import 'package:sweater/module/location.dart';
import 'package:sweater/module/user.dart';
import 'package:sweater/providers/location_provider.dart';
import 'package:sweater/providers/user_provider.dart';
import 'package:sweater/module/gender.dart';
import 'package:sweater/module/constitution.dart';

/*
  List<Location> _locationList = [];
  late Location _current;
  Location get current => _current;
  List get locationList => _locationList;
 */
main() {
  test('LocationProvider 초기화', () async {
    SharedPreferences.setMockInitialValues({}); //초기 SharedPreference 상태
    LocationProvider locationProvider = LocationProvider();
    int resultCode = await locationProvider.initLocation();
    expect(resultCode, ErrorType.successCode);
    expect(locationProvider.current.name, "동작구");
    expect(locationProvider.current.address, "서울특별시 동작구");
    expect(locationProvider.locationList.length, 1);
    expect(locationProvider.locationList[0].address, "서울특별시 동작구");
  });
  test('LocationProvider 불러오기', () async {
    SharedPreferences.setMockInitialValues({
      "my_location": """{
        "selected": "서울특별시 서초구",
        "location": [
          {"address": "서울특별시 서초구", "X": 59, "Y": 125},
          {"address": "서울특별시 동작구", "X": 59, "Y": 125}
        ]
      }"""
    }); //초기 SharedPreference 상태
    LocationProvider locationProvider = LocationProvider();
    int resultCode = await locationProvider.initLocation();
    expect(resultCode, ErrorType.successCode);
    expect(locationProvider.current.name, "서초구");
    expect(locationProvider.current.address, "서울특별시 서초구");
    expect(locationProvider.locationList.length, 2);
  });
  test('Location 추가 (addLocation)', () async {
    SharedPreferences.setMockInitialValues({
      "my_location": """{
        "selected": "서울특별시 서초구",
        "location": [
          {"address": "서울특별시 서초구", "X": 59, "Y": 125},
          {"address": "서울특별시 동작구", "X": 59, "Y": 125}
        ]
      }"""
    }); //초기 SharedPreference 상태
    LocationProvider locationProvider = LocationProvider();
    int initResultCode = await locationProvider.initLocation();
    expect(initResultCode, ErrorType.successCode);
    int resultCode = locationProvider.addLocation(
        Location.fromJson({"address": "서울특별시 중구", "X": 59, "Y": 125}));
    expect(resultCode, ErrorType.successCode);
    expect(locationProvider.locationList.length, 3);
  });
  test('중복되는 Location 추가 방지', () async {
    SharedPreferences.setMockInitialValues({
      "my_location": """{
        "selected": "서울특별시 서초구",
        "location": [
          {"address": "서울특별시 서초구", "X": 59, "Y": 125},
          {"address": "서울특별시 동작구", "X": 59, "Y": 125}
        ]
      }"""
    }); //초기 SharedPreference 상태
    LocationProvider locationProvider = LocationProvider();
    int initResultCode = await locationProvider.initLocation();
    expect(initResultCode, ErrorType.successCode);
    int resultCode = locationProvider.addLocation(
        Location.fromJson({"address": "서울특별시 서초구", "X": 59, "Y": 125}));
    expect(resultCode, ErrorType.duplicationErrorCode);
  });
  test('현재 위치를 바꿔주는 경우', () async {
    SharedPreferences.setMockInitialValues({
      "my_location": """{
        "selected": "서울특별시 서초구",
        "location": [
          {"address": "서울특별시 서초구", "X": 59, "Y": 125},
          {"address": "서울특별시 동작구", "X": 59, "Y": 125}
        ]
      }"""
    }); //초기 SharedPreference 상태
    LocationProvider locationProvider = LocationProvider();
    int resultCode = await locationProvider.initLocation();
    locationProvider.current =
        Location.fromJson({"address": "서울특별시 동작구", "X": 59, "Y": 125});

    expect(locationProvider.current.name, "동작구");
    expect(locationProvider.current.address, "서울특별시 동작구");
    expect(locationProvider.locationList.length, 2);
  });
  //set curren
  test('현재 상태 저장하기 (saveAll)', () async {
    SharedPreferences.setMockInitialValues({
      "my_location": """{
        "selected": "서울특별시 서초구",
        "location": [
          {"address": "서울특별시 서초구", "X": 59, "Y": 125},
          {"address": "서울특별시 동작구", "X": 59, "Y": 125}
        ]
      }"""
    }); //초기 SharedPreference 상태
    LocationProvider locationProvider = LocationProvider();
    await locationProvider.initLocation();

    locationProvider.current =
        Location.fromJson({"address": "서울특별시 동작구", "X": 59, "Y": 125});
    locationProvider.addLocation(
        Location.fromJson({"address": "서울특별시 중구", "X": 59, "Y": 125}));

    locationProvider.saveAll();
    LocationProvider newlocationProvider = LocationProvider();
    int resultCode = await newlocationProvider.initLocation();
    expect(resultCode, ErrorType.successCode);
    expect(newlocationProvider.current.name, "동작구");
    expect(locationProvider.locationList.length, 3);
  });
// saveAll
// deleteLocation
}
