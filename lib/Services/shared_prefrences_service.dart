// ignore_for_file: unnecessary_null_comparison

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencesService {
  static late SharedPreferences _sp;

  static initialize() async {
    _sp = await SharedPreferences.getInstance();
  }

  /// Character inflation Rate set by the User
  static double get inflation {
    return _sp.getDouble("inflation") ?? 1;
  }

  static set inflation(double value) {
    _sp.setDouble("inflation", value);
  }

  /// Character inflation Rate set by the User
  static String get currency {
    return _sp.getString("currency") ?? "\$";
  }

  static set currency(String value) {
    _sp.setString("currency", value);
  }

  /// whether to show time or not
  static bool get timeProgress {
    return _sp.getBool("timeProgress") ?? false;
  }

  static set timeProgress(bool value) {
    _sp.setBool("timeProgress", value);
  }

  /// whether to show money progress or not
  static bool get moneyProgress {
    return _sp.getBool("moneyProgress") ?? true;
  }

  static set moneyProgress(bool value) {
    _sp.setBool("moneyProgress", value);
  }
}
