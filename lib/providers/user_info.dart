import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// User 클래스 정의
class User extends ChangeNotifier {
  static int _constitution = 0;
  static int man = 1;
  static int woman = 2;
  static String manString = "남자";
  static String womanString = "여자";
  int _gender = man;
  int get constitution => _constitution;
  int get gender => _gender;
  set gender(int gender) {
    if (gender != man && gender != woman) {
      return;
    }
    _gender = gender;
    notifyListeners();
  }

  String get genderString => _gender == man ? "man" : "woman";

  User() {
    initInfo();
  }

  void initInfo() async {
    final prefs = await SharedPreferences.getInstance();
    gender = prefs.getInt('gender') ?? man;
    _constitution = prefs.getInt('constitution') ?? 0;
    notifyListeners();
  }

  void changeGender(int newGender) async {
    gender = newGender;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('gender', gender);
    notifyListeners();
  }

  void changeConstitution(int constitution) async {
    _constitution = constitution;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('constitution', _constitution);
    notifyListeners();
  }
}
