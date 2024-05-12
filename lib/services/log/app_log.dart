import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppLog {
  static void logValue(dynamic value) {
    if (kDebugMode) {
      log('----------------  Log  ------------------');
      log('Value : $value');
    }
  }

  static void logValueAndTitle(String title, dynamic value) {
    if (kDebugMode) {
      log('----------------  Log  ------------------');
      log('Title :  $title');
      log('Value : $value');
    }
  }

  static void debugPrint(dynamic value) {
    if (kDebugMode) {
      print('----------------  AppLog - Debug print  ------------------');
      print('Value : $value');
    }
  }
}
