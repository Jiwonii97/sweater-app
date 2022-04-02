import 'package:shared_preferences/shared_preferences.dart';

class RWData {
  static late SharedPreferences prefs;
  bool initialized = false;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
    initialized = true;
  }

  Future write_data(String key, String value) async {
    await prefs.setString(key, value);
  }

  String? read_data(String key) {
    return prefs.getString(key) ?? "";
  }
}
