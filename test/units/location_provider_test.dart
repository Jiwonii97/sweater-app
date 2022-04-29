import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweater/module/user.dart';
import 'package:sweater/providers/user_provider.dart';
import 'package:sweater/module/gender.dart';
import 'package:sweater/module/constitution.dart';

main() {
  test('LocationProvider 초기화', () async {
    SharedPreferences.setMockInitialValues({}); //초기 SharedPreference 상태
    UserProvider userProvider = UserProvider();
    await Future.delayed(const Duration(seconds: 1)); //1초 뒤
    expect(userProvider.gender, Gender.man);
    expect(userProvider.constitution, Constitution.feelNormal);
  });

  test('LocationProvider 변경', () async {
    SharedPreferences.setMockInitialValues({
      //SharedPreference 목업 생성
      'gender': Gender.man,
      'constitution': Constitution.feelNormal,
    });
    UserProvider userProvider = UserProvider();
    await Future.delayed(const Duration(seconds: 1)); //1초 뒤
    expect(userProvider.gender, Gender.man);
    expect(userProvider.constitution, Constitution.feelNormal);

    userProvider.changeGender(Gender.woman);
    userProvider.changeConstitution(Constitution.feelCold);

    await Future.delayed(const Duration(seconds: 1)); //1초 뒤
    expect(userProvider.gender, Gender.woman);
    expect(userProvider.constitution, Constitution.feelCold);
  });
}
