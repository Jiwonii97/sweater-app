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
          Cloth('top', 'sleeve', 'FFFFFF', '흰색 긴팔 티셔츠');
      expect(clothInstanceFromConstructor.majorCategory, 'top');
      expect(clothInstanceFromConstructor.minorCategory, 'sleeve');
      expect(clothInstanceFromConstructor.color, 'FFFFFF');
      expect(clothInstanceFromConstructor.fullName, '흰색 긴팔 티셔츠');
    });

    test('fromJson 생성 테스트', () {
      Map<String, dynamic> mockData = {
        'major': 'top',
        'minor': 'sleeve',
        'color': 'FFFFFF',
        'fullName': '흰색 슬리브 티셔츠',
      };
      clothInstanceFromJson = Cloth.fromJson(mockData);
      expect(clothInstanceFromJson.majorCategory, 'top');
      expect(clothInstanceFromJson.minorCategory, 'sleeve');
      expect(clothInstanceFromJson.color, 'white');
      expect(clothInstanceFromJson.fullName, '흰색 긴팔 티셔츠');
    });
  });

  group('Cloth 메소드 테스트', () {
    Cloth clothInstance1 = Cloth('top', 'sleeve', 'white', '흰색 긴팔 티셔츠');
    Cloth clothInstance2 = Cloth('top', 'mtm', 'black', '검정색 프린팅 맨투맨');
    test('Cloth getClothInfo 테스트', () {
      expect(clothInstance1.getClothInfo(), '흰색 긴팔 티셔츠');
      expect(clothInstance2.getClothInfo(), '검정색 프린팅 맨투맨');
    });

    test('Cloth getSVGFilePath', () {
      expect(
          clothInstance1.getSVGFilePath(), 'assets/cloth/top/long-sleeve.svg');
      expect(clothInstance2.getSVGFilePath(), 'assets/cloth/top/mtm.svg');
    });
  });
}
