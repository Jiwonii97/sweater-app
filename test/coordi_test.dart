import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweater/providers/coordi_provider.dart';

main() {
  group('Cloth class test', () {
    test('getClothInfo should be ', () {
      final clothInstance =
          Cloth('top', 'sleeve', const Color(0xffFFFFFF), ['crop', 'short']);
      expect(clothInstance.getClothInfo(), '흰 크롭 반팔티');
    });
  });
  group('Coordi class test', () {
    final clothList = [
      Cloth('top', 'sleeve', const Color(0xffFFFFFF), ['crop', 'short']),
      Cloth('bottom', 'jeans', const Color.fromARGB(255, 182, 211, 255), []),
      Cloth('outer', 'kardigan', Color.fromARGB(255, 0, 0, 0), ['check']),
    ];
    final coordiInstance = Coordi('https://insta/54fh09ser8g0s9er', clothList);
    test('getCoordiInfo', () {
      expect(coordiInstance.getCoordiInfo(),
          ['흰 크롭 반팔티', '연청 청바지', '검정 체크무늬 가디건']);
    });
  });

  group('CoordiManager class test', () {
    final coordiManagerInstance = CoordiManager();
    test('initCoordi', () {
      coordiManagerInstance.initCoordi();
      expect(clothInstance.getClothInfo(), '흰 크롭 반팔티');
    });
  })
}
