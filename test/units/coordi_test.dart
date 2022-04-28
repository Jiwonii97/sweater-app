import 'package:sweater/module/cloth.dart';
import 'package:sweater/module/coordi.dart';
import 'package:flutter_test/flutter_test.dart';

/*
  final String _url;
  final List<Cloth> _clothes;
  final int _gender;
*/

main() {
  test('코디 생성', () {
    Cloth top = Cloth("top", "sleeve", "FFFFFF", "흰 크롭 반팔 티셔츠");
    Cloth bottom = Cloth("bottom", "jeans", "9AB3D2", "연청 반바지");
    Coordi instance =
        Coordi("https://www.musinsa.com/mz/brandsnap?_m=&p=", [top, bottom]);
  });

  test('Coordi getCoordiInfo 테스트', () {
    //Coordi 에 '흰 크롭 반팔 티셔츠'를 반환하는 Cloth 클래스, '연청 청바지'를 반환하는 Cloth 클래스를 넣어 생성할 때
    //getCoordiInfo의 실행 결과는 ['흰 크롭 반팔 티셔츠','연청 청바지']이다.
    Cloth top = Cloth("top", "short_sleeve", "FFFFFF", "흰 크롭 반팔 티셔츠");
    Cloth bottom = Cloth("bottom", "short_jeans", "9AB3D2", "연청 반바지");
    Coordi instance =
        Coordi("https://www.musinsa.com/mz/brandsnap?_m=&p=", [top, bottom]);
    expect(instance.getCoordiInfo(), ['흰 크롭 반팔 티셔츠', '연청 반바지']);
  });

  test('Coordi getIllustUrl 테스트', () {
    //Coordi 에 '흰 크롭 반팔 티셔츠'를 반환하는 Cloth 클래스, '연청 짧은 청바지'를 반환하는 Cloth 클래스를 넣어 생성할 때
    //getIllustUrl 실행 결과는 ['asset/cloth/top/crop_short_sleeve.svg','asset/cloth/bottom/short_jeans.svg']이다.
    Cloth top = Cloth("top", "short_sleeve_tshirt", "FFFFFF", "흰 크롭 반팔 티셔츠");
    Cloth bottom = Cloth("bottom", "short_jeans", "9AB3D2", "연청 반바지");
    Coordi instance =
        Coordi("https://www.musinsa.com/mz/brandsnap?_m=&p=", [top, bottom]);
    expect(instance.getIllustUrl(), [
      'assets/cloth/top/short_sleeve_tshirt.svg',
      'assets/cloth/bottom/short_jeans.svg'
    ]);
  });
}
