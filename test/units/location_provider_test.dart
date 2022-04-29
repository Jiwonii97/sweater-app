import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
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
    locationProvider.initLocation();
    await Future.delayed(const Duration(seconds: 1)); //1초 뒤
    expect(locationProvider.current.name, "동작구");
    expect(locationProvider.current.address, "서울특별시 동작구");
    expect(locationProvider.locationList.length, 1);
    expect(locationProvider.locationList[0].address, "서울특별시 동작구");
  });
  test('LocationProvider 불러오기', () async {
    SharedPreferences.setMockInitialValues({
      "my_location":
          "{'selected':'서울특별시 서초구','location': [{'address':'서울특별시 서초구','X':59,'Y':125},{'address':'서울특별시 동작구','X':59,'Y':125}]}"
    }); //초기 SharedPreference 상태
    LocationProvider locationProvider = LocationProvider();
    locationProvider.initLocation();
    await Future.delayed(const Duration(seconds: 1)); //1초 뒤
    expect(locationProvider.current.name, "서초구");
    expect(locationProvider.current.address, "서울특별시 서초구");
    expect(locationProvider.locationList.length, 2);
  });
  test('없는 Location 추가시 ', () async {
    SharedPreferences.setMockInitialValues({
      "my_location":
          "{'selected':'서울특별시 서초구','location': [{'address':'서울특별시 서초구','X':59,'Y':125},{'address':'서울특별시 동작구','X':59,'Y':125}]}"
    }); //초기 SharedPreference 상태
    LocationProvider locationProvider = LocationProvider();
    locationProvider.initLocation();
    await Future.delayed(const Duration(seconds: 1)); //1초 뒤
    expect(locationProvider.current.name, "서초구");
    expect(locationProvider.current.address, "서울특별시 서초구");
    expect(locationProvider.locationList.length, 2);
  });
  test('set current', () async {
    SharedPreferences.setMockInitialValues({
      "my_location":
          "{'selected':'서울특별시 서초구','location': [{'address':'서울특별시 서초구','X':59,'Y':125},{'address':'서울특별시 동작구','X':59,'Y':125}]}"
    }); //초기 SharedPreference 상태
    LocationProvider locationProvider = LocationProvider();
    locationProvider.initLocation();
    await Future.delayed(const Duration(seconds: 1)); //1초 뒤
    expect(locationProvider.current.name, "서초구");
    expect(locationProvider.current.address, "서울특별시 서초구");
    expect(locationProvider.locationList.length, 2);

    expect(locationProvider.current.name, "동작구");
    expect(locationProvider.current.address, "서울특별시 동작구");
    expect(locationProvider.locationList.length, 2);
  });
  //set curren
  test('set current', () async {
    SharedPreferences.setMockInitialValues({
      "my_location":
          "{'selected':'서울특별시 서초구','location': [{'address':'서울특별시 서초구','X':59,'Y':125},{'address':'서울특별시 동작구','X':59,'Y':125}]}"
    }); //초기 SharedPreference 상태
    LocationProvider locationProvider = LocationProvider();
    locationProvider.initLocation();
    await Future.delayed(const Duration(seconds: 1)); //1초 뒤
    expect(locationProvider.current.name, "서초구");
    expect(locationProvider.current.address, "서울특별시 서초구");
    expect(locationProvider.locationList.length, 2);

    expect(locationProvider.current.name, "동작구");
    expect(locationProvider.current.address, "서울특별시 동작구");
    expect(locationProvider.locationList.length, 2);
  });
// addLocation
// initLocation
// saveAll
// deleteLocation
}
