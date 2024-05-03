import 'package:flutter/material.dart';

import '../../ui/screens/add_bmi/screen/add_bmi_screen.dart';
import '../../ui/screens/auth/login/screen/login_screen.dart';
import '../../ui/screens/notifications/notifications_screen.dart';
import '../../ui/screens/onboard/screen/onboard_screen.dart';
import '../../ui/screens/tabs/main_tab/screen/tabs_screen.dart';
import '../../ui/screens/update_bmi/screen/update_bmi_screen.dart';

class AppRoutes {
  static final Map<String, Widget Function(BuildContext)> _routes = {
    TabsScreen.routeName: (_) => const TabsScreen(),
    OnboardScreen.routeName: (_) => const OnboardScreen(),
    NotificationsScreen.routeName: (_) => const NotificationsScreen(),
    LoginScreen.routeName: (_) => const LoginScreen(),
    UpdateBmiScreen.routeName: (_) => const UpdateBmiScreen(),
    AddBmiScreen.routeName: (_) => const AddBmiScreen(),
  };

  static const String _initialRoute = '/';

  static Map<String, Widget Function(BuildContext)> get getRoutes {
    return _routes;
  }

  static String get getInitialRoute {
    return _initialRoute;
  }
}
