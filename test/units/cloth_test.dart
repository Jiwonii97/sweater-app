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
          Cloth('top', 'long_sleeve_tshirt', 'white', '흰색 긴팔 티셔츠');
      expect(clothInstanceFromConstructor.majorCategory, 'top');
      expect(clothInstanceFromConstructor.minorCategory, 'long_sleeve_tshirt');
      expect(clothInstanceFromConstructor.color, 'white');
      expect(clothInstanceFromConstructor.fullName, '흰색 긴팔 티셔츠');
    });

    test('fromJson 생성 테스트', () {
      Map<String, dynamic> mockData = {
        'major': 'top',
        'minor': 'sleeve',
        'color': 'white',
        'full_name': '흰색 긴팔 티셔츠',
      };
      clothInstanceFromJson = Cloth.fromJson(mockData);
      expect(clothInstanceFromJson.majorCategory, 'top');
      expect(clothInstanceFromJson.minorCategory, 'sleeve');
      expect(clothInstanceFromJson.color, 'white');
      expect(clothInstanceFromJson.fullName, '흰색 긴팔 티셔츠');
    });
  });

  group('Cloth 메소드 테스트', () {
    Cloth clothInstance1 = Cloth('top', 'long_sleeve', 'white', '흰색 긴팔 티셔츠');
    Cloth clothInstance2 = Cloth('top', 'mtm', 'black', '검정색 프린팅 맨투맨');
    test('Cloth getClothInfo 테스트', () {
      expect(clothInstance1.getClothInfo(), '흰색 긴팔 티셔츠');
      expect(clothInstance2.getClothInfo(), '검정색 프린팅 맨투맨');
    });

    test('Cloth getPNGFilePath', () {
      expect(clothInstance1.getPNGFilePath(),
          'assets/cloth/top/long_sleeve/long_sleeve-white.png');
      expect(clothInstance2.getPNGFilePath(),
          'assets/cloth/top/mtm/mtm-black.png');
    });
  });
}
