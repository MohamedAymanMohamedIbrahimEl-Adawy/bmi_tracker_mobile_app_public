import 'dart:async';

import 'package:uni_links/uni_links.dart';

import '../log/app_log.dart';

class AppLinksHandler {
  static void initUniLinks() async {
    final String? initialLink = await getInitialLink();
    AppLog.logValue("We are in init Uni Links: ");

    if (initialLink != null) {
      AppLog.logValue(
          "The is opened via a deep link via Uri links  --> getInitialLink() method");
      AppLog.logValue("Item was detected --> ");
      AppLog.logValue(initialLink);
      await handleDeepLinks(initialLink);
    }
  }

  static Future<void> handleDeepLinks(String deepLink) async {
    if (deepLink.contains("promo_code")) {
      // Do the function or the navigation that you want to excute when opening link

      final Uri parsedUrl = Uri.parse(deepLink);

      final String promoCode = parsedUrl.queryParameters["promo_code"]!;
      AppLog.logValueAndTitle("Promo code", promoCode);
    } else {
      //
    }
  }
}
