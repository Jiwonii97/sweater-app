import 'package:sweater/module/constitution.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test('Constitution 생성자 테스트', () {
    Constitution constitution = Constitution(Constitution.feelNormal);
    expect(constitution.constitution, Constitution.feelNormal);
  });
  test('Constitution 변경 테스트', () {
    Constitution constitution = Constitution(Constitution.feelNormal);

    expect(constitution.constitution, Constitution.feelNormal);
    constitution.constitution = Constitution.feelCold;
    expect(constitution.constitution, Constitution.feelCold);
  });
}
