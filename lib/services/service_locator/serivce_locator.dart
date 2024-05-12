import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/auth/auth_repo.dart';
import '../../data/repositories/bmi/bmi_repo.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/bmi/bmi_provider.dart';
import '../database/app_database.dart';
import '../error/error_handler.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> initServices() async {
  // Get sqflite database instance
  final database = await AppDatabase.getInstance();

  final SharedPreferences pref = await SharedPreferences.getInstance();
  // Register Shared Prefs
  serviceLocator.registerLazySingleton<SharedPreferences>(() => pref);

  // // Register connectivity
  // serviceLocator.registerLazySingleton(() => Connectivity());

  // Registering error handler
  serviceLocator.registerLazySingleton<FirebaseErrorHandler>(
      () => FirebaseErrorHandler());
  serviceLocator
      .registerLazySingleton<SQLErrorHandler>(() => SQLErrorHandler());

  // Registering Repos
  serviceLocator.registerLazySingleton<FirebaseAuthRepo>(
    () => FirebaseAuthRepo(
      firebaseAuth: FirebaseAuth.instance,
      errorHandler: serviceLocator<FirebaseErrorHandler>(),
      sharedPreferences: serviceLocator<SharedPreferences>(),
    ),
  );
  serviceLocator.registerLazySingleton<SqlAuthRepo>(
    () => SqlAuthRepo(
      database: database,
      errorHandler: serviceLocator<SQLErrorHandler>(),
      sharedPreferences: serviceLocator<SharedPreferences>(),
    ),
  );
  serviceLocator.registerLazySingleton<FirebaseBmiRepo>(
    () => FirebaseBmiRepo(
      errorHandler: serviceLocator<FirebaseErrorHandler>(),
      sharedPreferences: serviceLocator<SharedPreferences>(),
      firebaseFirestore: FirebaseFirestore.instance,
    ),
  );

  serviceLocator.registerLazySingleton<SqlBmiRepo>(
    () => SqlBmiRepo(
      errorHandler: serviceLocator<SQLErrorHandler>(),
      sharedPreferences: serviceLocator<SharedPreferences>(),
      database: database,
    ),
  );

  // Registering providers
  serviceLocator.registerFactory<BmiProvider>(
    () => BmiProvider(
      // To Use sqlite as a repository
      bmiRepository: serviceLocator<SqlBmiRepo>(),
      // To Use firebase as a repository --> un comment the next line and comment the above line
      // bmiRepository: serviceLocator<FirebaseBmiRepo>(),
    ),
  );

  serviceLocator.registerFactory<AuthProvider>(
    () => AuthProvider(
      // To Use sqlite as a repository
      authRepository: serviceLocator<SqlAuthRepo>(),
      // To Use firebase as a repository --> un comment the next line and comment the above line
      // bmiRepository: serviceLocator<FirebaseAuthRepo>(),
    ),
  );
}
