import 'package:flutter/foundation.dart';

class ApiConstants {
  // Local URL : http://172.16.16.42:4200/api

  // http://54.79.104.40:4200/api
  static const String baseURL = kReleaseMode
      ? 'http://54.79.104.40:4200/api'
      : 'http://54.79.104.40:4200/api';

  static const int snackBarDelay = 2;
}
