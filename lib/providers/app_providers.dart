import 'package:provider/provider.dart';

import 'auth/auth_provider.dart';
import '../services/service_locator/serivce_locator.dart';
import 'bmi/bmi_provider.dart';

class AppProviders {
  static final List _providers = [
    ChangeNotifierProvider<BmiProvider>(
      create: (_) => serviceLocator<BmiProvider>(),
    ),
    ChangeNotifierProvider<AuthProvider>(
      create: (_) => serviceLocator<AuthProvider>(),
    ),
  ];

  static List<ChangeNotifierProvider> get getProviders {
    return [..._providers];
  }
}
