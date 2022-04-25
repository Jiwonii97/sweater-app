import 'package:sweater/module/cloth.dart';
import 'package:flutter_test/flutter_test.dart';

/* Cloth의 속성
  final String _majorCategory;
  final String _minorCategory;
  final String _color; // white,black,navy 등
  final List<dynamic> _features;
  final String _thickness; // "","thin","thick",
*/
main() {
  group('Cloth 생성자 테스트 그룹', () {
    Cloth clothInstanceFromConstructor; //생성자로 만든 Cloth 클래스 인스턴스
    Cloth clothInstanceFromJson; // fromJson을 통해 만든 Cloth 클래스 인스턴스
    test('Constructor 생성 테스트', () {
      clothInstanceFromConstructor =
          Cloth('top', 'sleeve', 'white', ['crop'], '');
      expect(clothInstanceFromConstructor.majorCategory, 'top');
      expect(clothInstanceFromConstructor.minorCategory, 'sleeve');
      expect(clothInstanceFromConstructor.color, 'white');
      expect(clothInstanceFromConstructor.features, ['crop']);
      expect(clothInstanceFromConstructor.thickness, '');
    });

    test('fromJson 생성 테스트', () {
      Map<String, dynamic> mockData = {
        'major': 'top',
        'minor': 'sleeve',
        'color': 'white',
        'features': ['crop'],
        'thickness': ''
      };
      clothInstanceFromJson = Cloth.fromJson(mockData);
      expect(clothInstanceFromJson.majorCategory, 'top');
      expect(clothInstanceFromJson.minorCategory, 'sleeve');
      expect(clothInstanceFromJson.color, 'white');
      expect(clothInstanceFromJson.features, ['']);
      expect(clothInstanceFromJson.thickness, '');
    });
  });

  group('Cloth 메소드 테스트', () {
    Cloth clothInstance1 =
        Cloth('top', 'sleeve', 'white', ['long', 'crop'], '');
    Cloth clothInstance2 = Cloth('top', 'mtm', 'black', ['short'], 'thin');
    test('Cloth getClothInfo 테스트', () {
      expect(clothInstance1.getClothInfo(), '흰색 긴 크롭 티셔츠');
      expect(clothInstance2.getClothInfo(), '검정색 짧은 얇은 맨투맨');
    });

    test('Cloth getSVGFilePath', () {
      expect(clothInstance1.getSVGFilePath(),
          'assets/cloth/top/long-crop-sleeve.svg');
      expect(clothInstance2.getSVGFilePath(), 'assets/cloth/top/short-mtm.svg');
    });
  });
}
