import 'package:sweater/module/constitution.dart';
import 'package:sweater/module/gender.dart';

class User {
  Gender _gender = Gender(Gender.man);
  Constitution _constitution = Constitution(Constitution.feelNormal);
  set gender(int gender) {
    _gender.gender = gender;
  }

  int get gender {
    return _gender.gender;
  }

  set constitution(int constitute) {
    _constitution.constitution = constitute;
  }

  int get constitution {
    return _constitution.constitution;
  }

  User(int gender, int constitution) {
    this.gender = gender;
    this.constitution = constitution;
  }
}
