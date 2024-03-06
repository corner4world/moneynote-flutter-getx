import 'package:shared_preferences/shared_preferences.dart';

class Token {

  static Future<bool> save(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('accessToken', token);
  }

  static Future<String> get() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') ?? '';
  }

}