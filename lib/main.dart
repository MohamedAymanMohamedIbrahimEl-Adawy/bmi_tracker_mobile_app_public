import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/constants/constants.dart';
import 'providers/app_providers.dart';
import 'providers/auth/auth_provider.dart';
import 'serivce_locator.dart';
import 'services/localization/app_localization.dart';
import 'services/notifications/notifications_services.dart';
import 'services/routes/app_rotues.dart';
import 'services/theme/app_theme.dart';
import 'ui/screens/auth/login/screen/login_screen.dart';
import 'ui/screens/onboard/screen/onboard_screen.dart';
import 'ui/screens/tabs/main_tab/screen/tabs_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigatorState => navigatorKey.currentState;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init localization
  await EasyLocalization.ensureInitialized();

  // Init adaptive theme
  final AdaptiveThemeMode? savedThemeMode = await AdaptiveTheme.getThemeMode();

  // Inject dependancies
  await initServices();

  // Init firebase
  await Firebase.initializeApp();

  // Handle firebase background notifications
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  // Enable firebase analytics
  await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

  if (!kDebugMode) {
    const fatalError = true;
    // Non-async exceptions
    FlutterError.onError = (errorDetails) {
      if (fatalError) {
        // If you want to record a "fatal" exception
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        // ignore: dead_code
      } else {
        // If you want to record a "non-fatal" exception
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      }
    };
    // Async exceptions
    PlatformDispatcher.instance.onError = (error, stack) {
      if (fatalError) {
        // If you want to record a "fatal" exception
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        // ignore: dead_code
      } else {
        // If you want to record a "non-fatal" exception
        FirebaseCrashlytics.instance.recordError(error, stack);
      }
      return true;
    };
  }

  runApp(
    MultiProvider(
      providers: AppProviders.getProviders,
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: AppLocalization.getSupportedLocales,
        fallbackLocale: AppLocalization.fallbackLocale,
        startLocale: AppLocalization.startLocale,
        saveLocale: true,
        child: MyApp(
          savedTheme: savedThemeMode,
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedTheme;
  const MyApp({super.key, this.savedTheme});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bool isFirstOpen = serviceLocator<SharedPreferences>().getBool(
          AppConstants.isFirstOpenKey,
        ) ??
        true;
    final bool isLogin =
        Provider.of<AuthProvider>(context, listen: false).getLoginStatus();
    return AdaptiveTheme(
      light: AppTheme.getTheme(false),
      dark: AppTheme.getTheme(true),
      initial: savedTheme ?? AdaptiveThemeMode.dark,
      builder: (light, dark) => MaterialApp(
        navigatorKey: navigatorKey,
        darkTheme: dark,
        theme: light,
        title: 'AG DEVELOPMENT',
        themeAnimationStyle: AnimationStyle(
          duration: const Duration(
            milliseconds: 800,
          ),
          curve: Curves.linear,
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: AppRoutes.getRoutes,
        // initialRoute: AppRoutes().getInitialRoute,
        home: isFirstOpen
            ? const OnboardScreen()
            : isLogin
                ? const TabsScreen()
                : const LoginScreen(),
      ),
    );
  }
}
