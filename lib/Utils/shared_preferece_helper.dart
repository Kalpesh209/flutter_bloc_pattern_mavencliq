import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static SharedPreferenceHelper? _sharedPreferenceHelper;
  SharedPreferences? _sharedPreferences;

  SharedPreferences get sharedPreferences => _sharedPreferences!;

  factory SharedPreferenceHelper.getInstance() {
    _sharedPreferenceHelper ??= SharedPreferenceHelper._internal();
    return _sharedPreferenceHelper!;
  }

  SharedPreferenceHelper._internal();

  Future<void> initializeSharedPreference() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static Future<bool> saveLoginToken(String value) async {
    return _sharedPreferenceHelper!._sharedPreferences!
        .setString("LoginToken", value);
  }

  static Future<String> _safeString(String? request) async {
    String? str = request;
    if (str == null || str.isEmpty) {
      return '';
    }
    return str;
  }

  static Future<bool> logOut() {
    print('Clearing shared pref data');
    return _sharedPreferenceHelper!.sharedPreferences.clear();
  }
}
