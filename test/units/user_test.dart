import 'package:flutter_test/flutter_test.dart';
import 'package:sweater/module/user.dart';
import 'package:sweater/module/gender.dart';
import 'package:sweater/module/constitution.dart';

main() {
  test('User 클래스 생성', () {
    User user = User(Gender.man, Constitution.feelNormal);
    expect(user.gender, Gender.man);
    expect(user.constitution, Constitution.feelNormal);
  });

  test('User 클래스 변경', () {
    User user = User(Gender.man, Constitution.feelNormal);
    expect(user.gender, Gender.man);
    expect(user.constitution, Constitution.feelNormal);

    user.constitution = Constitution.feelCold;
    user.gender = Gender.woman;

    expect(user.gender, Gender.woman);
    expect(user.constitution, Constitution.feelCold);
  });
}
