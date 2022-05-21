import 'package:sweater/module/cloth.dart';
import 'package:sweater/module/coordi.dart';
import 'package:flutter_test/flutter_test.dart';

/*
  final String _url;
  final List<Cloth> _clothes;
  final int _gender;
*/

main() {
  Cloth top = Cloth("top", "short_sleeve_tshirt", "white", "흰 크롭 반팔 티셔츠");
  Cloth bottom = Cloth("bottom", "short_jeans", "yeon_chung", "연청 반바지");
  String style = "댄디";

  test('코디 생성', () {
    Coordi instance = Coordi(
        "https://www.musinsa.com/mz/brandsnap?_m=&p=", [top, bottom], style);
  });

  test('Coordi getCoordiInfo 테스트', () {
    //Coordi 에 '흰 크롭 반팔 티셔츠'를 반환하는 Cloth 클래스, '연청 청바지'를 반환하는 Cloth 클래스를 넣어 생성할 때
    //getCoordiInfo의 실행 결과는 ['흰 크롭 반팔 티셔츠','연청 청바지']이다.
    Coordi instance = Coordi(
        "https://www.musinsa.com/mz/brandsnap?_m=&p=", [top, bottom], style);
    expect(instance.getCoordiInfo(), ['흰 크롭 반팔 티셔츠', '연청 반바지']);
  });

  test('Coordi getIllustUrl 테스트', () {
    //Coordi 에 '흰 크롭 반팔 티셔츠'를 반환하는 Cloth 클래스, '연청 짧은 청바지'를 반환하는 Cloth 클래스를 넣어 생성할 때
    //getIllustUrl 실행 결과는 ['asset/cloth/top/crop_short_sleeve.svg','asset/cloth/bottom/short_jeans.svg']이다.
    Coordi instance = Coordi(
        "https://www.musinsa.com/mz/brandsnap?_m=&p=", [top, bottom], style);
    expect(instance.getIllustUrl(), [
      'assets/cloth/top/short_sleeve_tshirt/short_sleeve_tshirt-white.png',
      'assets/cloth/bottom/short_jeans/short_jeans-yeon_chung.png'
    ]);
  });

  test('Coordi style 테스트', () {
    //Coordi 에 '흰 크롭 반팔 티셔츠'를 반환하는 Cloth 클래스, '연청 짧은 청바지'를 반환하는 Cloth 클래스를 넣어 생성할 때
    //getIllustUrl 실행 결과는 ['asset/cloth/top/crop_short_sleeve.svg','asset/cloth/bottom/short_jeans.svg']이다.
    Coordi instance = Coordi(
        "https://www.musinsa.com/mz/brandsnap?_m=&p=", [top, bottom], style);
    expect(instance.style, "댄디");
  });
}
