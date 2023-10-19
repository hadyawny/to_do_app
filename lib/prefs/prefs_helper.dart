import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static late SharedPreferences prefs;


  static saveTheme(String mode) async {
    await prefs.setString("mode", mode);
  }

  static String getTheme() {
    return prefs.getString("mode") ?? "light";
  }
}
