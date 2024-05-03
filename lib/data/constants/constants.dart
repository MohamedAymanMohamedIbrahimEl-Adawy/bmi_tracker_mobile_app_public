class AppConstants {
  static const appName = 'BMI Tracker';

  static const String email = 'moadawy20.eng@yahoo.com';
  static const String andriodPackageId = 'com.ag.bmitracker';
  static const String appStoreUrl =
      'https://play.google.com/store/apps/dev?id=';
  static const String androidGooglePlayUrl =
      'https://play.google.com/store/apps/details?id=com.ag.bmitracker';

  static const String websiteUrl = 'https://www.facebook.com/ag.group.dev/';
  static const String welcomeTitle = 'Welcome To AG DEVELOPMENT';
  static const String welcomeBody = '';
  static const String supportMessage = 'Need Support';

  static const String phoneCallUrll = 'tel:+$phoneNumber';

  static const String shareAppUrl = androidGooglePlayUrl;
  // '$appName\nGoogle Play:\n$androidGooglePlayUrl\n\nWebsite:\n$websiteUrl';
  //'$appName\nGoogle Play:\n$androidGooglePlayUrl\n\nApp Store\n$appStoreUrl\n\nWebsite:\n$websiteUrl';
  static const String fbFallbackUrl = 'https://www.facebook.com/ag.group.dev';
  static const String fbPageId = '102113725984804 ';
  static const String whatsUrl =
      'https://api.whatsapp.com/send/?phone=201129092622&text&type=phone_number&app_absent=0';
  static const String phoneNumber = '+201129092622';
  static const String tiktok = 'https://www.tiktok.com/@....';
  static const String instgram = 'https://www.instagram.com/ag.group.dev/';
  static const String telegram = 'https://t.me/....';

  //
  static const String privacyPolicy =
      'https://doc-hosting.flycricket.io/privacy-policy-for-bmi-tracker/1cffbe90-c0f5-493d-9317-3e34f4e1d604/privacy';

  // Shared preferences keys
  static String isFirstOpenKey = 'isFirstOpen';
  static String dateFirstTimeOpenKey = 'dateFirstTimeOpen';
  static String fcmTokenKey = 'fcmToken';
  static String userLoginToken = 'userLoginToken';
  static String languageCodeKey = 'languageKey';
  static String countryCodeKey = 'countryCode';
  static String isLoggedInKey = 'isLoggedIn';
  static String logginTokenKey = 'loginToken';
  static String userIdKey = 'userId';
  static String userNameKey = 'userName';
  static String passwordKey = 'password';
  static String langaugeNumberKey = 'langaugeNumber';

  // apiEndpoints
  static const baseUrl = '';
  static String bmiResults = '';

  static String orderStatusTypes = '$baseUrl/';
  static String orderById(int id) => "$baseUrl/";

  static String loginApi = '$baseUrl/';
}
