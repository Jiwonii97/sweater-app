import 'package:sweater/module/gender.dart';

class Constitution {
  static const int feelVeryHot = 4;
  static const int feelHot = 2;
  static const int feelNormal = 0;
  static const int feelCold = -2;
  static const int feelVeryCold = -4;
  static const String feelVeryHotString = "더위를 많이 타요";
  static const String feelHotString = "더위를 조금 타요";
  static const String feelNormalString = "보통이에요";
  static const String feelColdString = "추위를 조금 타요";
  static const String feelVeryColdString = "추위를 많이 타요";

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
