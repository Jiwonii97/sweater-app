import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweater/module/constitution.dart';
import 'package:sweater/module/gender.dart';
import 'package:sweater/module/user.dart';

// User 클래스 정의
class UserProvider extends ChangeNotifier {
  final User _user = User(Gender.man, Constitution.feelNormal);
  int get gender {
    return _user.gender;
  }

  int get constitution {
    return _user.constitution;
  }

  UserProvider() {
    initUserInfo();
  }

  void initUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _user.gender = (prefs.getInt('gender') ?? Gender.man);
      _user.constitution =
          prefs.getInt('constitution') ?? Constitution.feelNormal;
    } catch (e) {
      print('UserProvider의 initUserInfo에서 에러가 발생했습니다. $e');
    }

    notifyListeners();
  }

  void changeGender(int newGender) async {
    try {
      _user.gender = newGender;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('gender', newGender);
    } catch (e) {
      print('UserProvider의 changeGender에서 에러가 발생했습니다. $e');
    }
    notifyListeners();
  }

  void changeConstitution(int newConstitution) async {
    try {
      _user.constitution = newConstitution;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('constitution', newConstitution);
    } catch (e) {
      print('UserProvider의 changeConstitution에서 에러가 발생했습니다. $e');
    }
    notifyListeners();
  }
}
