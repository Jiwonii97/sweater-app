import 'package:flutter_test/flutter_test.dart';
import 'package:sweater/module/location.dart';
import 'package:sweater/module/user.dart';
import 'package:sweater/module/gender.dart';
import 'package:sweater/module/constitution.dart';

/*
  final String _address;
  final Map _position;

  Location(this._name, this._position);
*/
main() {
  test('Location 클래스 생성', () {
    Location location = Location('서울특별시 동작구', {'X': 59, "Y": 125});
    expect(location.X, 59);
    expect(location.Y, 125);
    expect(location.address, "서울특별시 동작구");
    expect(location.name, "동작구");
  });

  test('Location fromJson클래스 생성', () {
    Location location =
        Location.fromJson({'address': '서울특별시 동작구', 'X': 59, "Y": 125});
    expect(location.X, 59);
    expect(location.Y, 125);
    expect(location.address, "서울특별시 동작구");
    expect(location.name, "동작구");
  });
}
