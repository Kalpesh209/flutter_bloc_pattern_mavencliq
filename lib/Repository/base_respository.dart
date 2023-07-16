import 'package:flutter/foundation.dart';
import 'package:mavencliq/Network/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseRepository {
  @protected
  late ApiService apiService;

  BaseRepository() {
    apiService = ApiService.getInstance();
    // sharedPreferences = SharedPreferenceHelper.getInstance().sharedPreferences;
    // database = RazullDatabase.getInstance();
  }
}
