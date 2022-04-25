class Gender {
  static const int man = 1;
  static const int woman = 2;
  static const String manString = "남자";
  static const String womanString = "여자";

  int _gender;
  set gender(int newGender) {
    if (_gender != man && _gender != woman) {
      throw const FormatException("gender는 1 또는 2 여야 합니다.");
    } else {
      _gender = newGender;
    }
  }

  int get gender {
    return _gender;
  }

  Gender(this._gender);

  bool isMan() {
    if (_gender == man) {
      return true;
    } else {
      return false;
    }
  }

  bool isWoman() {
    if (_gender == woman) {
      return true;
    } else {
      return false;
    }
  }
}
