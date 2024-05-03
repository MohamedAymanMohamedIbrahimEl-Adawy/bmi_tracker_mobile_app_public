import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppLog {
  static void logValue(dynamic value) {
    if (kDebugMode) {
      log('----------------  Log  ------------------');
      print('Value : $value');
    }
  }

  static void logValueAndTitle(String title, dynamic value) {
    if (kDebugMode) {
      log('----------------  Log  ------------------');
      print('Title :  $title');
      print('Value : $value');
    }
  }
}
