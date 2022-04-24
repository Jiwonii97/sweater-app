import 'dart:math';

import 'package:sweater/module/gender.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('남,여 상수', () {
    expect(Gender.manString, '남자');
    expect(Gender.womanString, '여자');
    expect(Gender.man, 1);
    expect(Gender.woman, 2);
  });
  test('Gender 생성 & 성별 확인 테스트', () {
    Gender man = Gender(Gender.man);
    Gender woman = Gender(Gender.woman);
    expect(man.isMan(), true);
    expect(woman.isMan(), false);
    expect(man.isWoman(), false);
    expect(woman.isWoman(), true);
  });

  test('Gender 변환 테스트', () {
    Gender willBeWoman = Gender(Gender.man);
    Gender willBeMan = Gender(Gender.woman);
    expect(willBeWoman.isMan(), true);
    expect(willBeMan.isWoman(), true);

    willBeWoman.gender = Gender.woman;
    willBeMan.gender = Gender.man;
    expect(willBeWoman.isMan(), false);
    expect(willBeMan.isWoman(), false);
    expect(willBeWoman.isWoman(), true);
    expect(willBeMan.isMan(), true);
  });
}
