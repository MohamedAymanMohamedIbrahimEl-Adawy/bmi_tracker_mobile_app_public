import 'dart:async';

import 'package:app_links/app_links.dart';

import '../log/app_log.dart';

class AppLinksHandler {
  static void initUniLinks() async {
    AppLinks appLinks = AppLinks();
    final Uri? initialLink = await appLinks.getInitialLink();
    AppLog.logValue("We are in init Uni Links: ");

    if (initialLink != null) {
      AppLog.logValue(
          "The is opened via a deep link via Uri links  --> getInitialLink() method");
      AppLog.logValue("Item was detected --> ");
      AppLog.logValue(initialLink);
      await handleDeepLinks(initialLink);
    }
  }

  static Future<void> handleDeepLinks(Uri deepLink) async {
    // Do the function or the navigation that you want to excute when opening link
  }
}
