import 'package:sweater/module/gender.dart';

class Constitution {
  static int feelVeryHot = 2;
  static int feelHot = 1;
  static int feelNormal = 0;
  static int feelCold = -1;
  static int feelVeryCold = -2;
  static String feelVeryHotString = "더위를 많이 타요";
  static String feelHotString = "더위를 조금 타요";
  static String feelNormalString = "보통이에요";
  static String feelColdString = "추위를 조금 타요";
  static String feelVeryColdString = "추위를 많이 타요";

  int _constitution;
  int get constitution {
    return _constitution;
  }

  set constitution(int newConstitution) {
    if (newConstitution != feelVeryHot &&
        newConstitution != feelHot &&
        newConstitution != feelNormal &&
        newConstitution != feelCold &&
        newConstitution != feelVeryCold) {
      throw const FormatException('맞지 않는 형식의 체질입니다.');
    } else {
      _constitution = newConstitution;
    }
  }

  Constitution(this._constitution);
}
