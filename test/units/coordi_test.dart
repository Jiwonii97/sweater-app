import 'package:sweater/module/coordi.dart';
import 'package:flutter_test/flutter_test.dart';

/*
  final String _url;
  final List<Cloth> _clothes;
  final int _gender;
*/

main() {
  test('코디 생성', () {
    //Coordi instance = Coordi(this._url, this._clothes);
  });

  test('Coordi getCoordiInfo 테스트', () {
    //Coordi 에 '흰 크롭 반팔 티셔츠'를 반환하는 Cloth 클래스, '연청 짧은 청바지'를 반환하는 Cloth 클래스를 넣어 생성할 때
    //getCoordiInfo의 실행 결과는 ['흰 크롭 반팔 티셔츠','연청 짧은 청바지']이다.
  });

  test('Coordi getIllustUrl 테스트', () {
    //Coordi 에 '흰 크롭 반팔 티셔츠'를 반환하는 Cloth 클래스, '연청 짧은 청바지'를 반환하는 Cloth 클래스를 넣어 생성할 때
    //getIllustUrl 실행 결과는 ['asset/cloth/top/crop_short_sleeve.svg','asset/cloth/bottom/short_jeans.svg']이다.
  });
}
