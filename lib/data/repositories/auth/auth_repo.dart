import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../services/error/error_handler.dart';

import '../../../services/log/app_log.dart';
import '../../constants/constants.dart';
import '../../models/login/login_request_model.dart';
import '../../models/response/app_response.dart';

abstract class AuthRepository {
  final ErrorHandler errorHandler;
  final SharedPreferences sharedPreferences;

  AuthRepository({
    required this.errorHandler,
    required this.sharedPreferences,
  });
  Future<AppResponse> login(LoginRequestModel loginRequestModel);
  Future<AppResponse> logout();
  Future<AppResponse> register();
  Future<AppResponse> deleteAccount();
  Future<void> setLoginStatus(bool status);
  bool getLoginStatus();
  Future<void> setName(String name);
  Future<void> setUserId(String userId);
  String getName();
  String getUserId();
  Future<void> clearSession();
}

// Using Firebase Auth as a remote authentication repository
class FirebaseAuthRepo extends AuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepo(
      {required FirebaseAuth firebaseAuth,
      required super.errorHandler,
      required super.sharedPreferences,})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<AppResponse> deleteAccount() async {
    try {
      return AppResponse.withSuccess();
    } catch (e) {
      return AppResponse.withError();
    }
  }

  @override
  Future<AppResponse> login(LoginRequestModel loginRequestModel) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInAnonymously();

      AppLog.logValue(userCredential.user?.uid);

      return AppResponse.withSuccess(
        data: {
          'id': userCredential.user?.uid,
        },
      );
    } catch (e) {
      return AppResponse.withError(
        message: errorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<AppResponse> logout() async {
    try {
      await _firebaseAuth.signOut();
      return AppResponse.withSuccess();
    } catch (e) {
      return AppResponse.withError(
        message: errorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<AppResponse> register() async {
    try {
      return AppResponse.withSuccess();
    } catch (e) {
      return AppResponse.withError();
    }
  }

  @override
  bool getLoginStatus() {
    return sharedPreferences.getBool(AppConstants.isLoggedInKey) ?? false;
  }

  @override
  Future<void> setLoginStatus(bool status) async {
    await sharedPreferences.setBool(AppConstants.isLoggedInKey, status);
  }

  @override
  Future<void> setName(String name) async {
    await sharedPreferences.setString(AppConstants.userNameKey, name);
  }

  @override
  Future<void> setUserId(String userId) async {
    await sharedPreferences.setString(AppConstants.userIdKey, userId);
  }

  @override
  String getName() {
    return sharedPreferences.getString(AppConstants.userNameKey) ?? '';
  }

  @override
  String getUserId() {
    return sharedPreferences.getString(AppConstants.userIdKey) ?? '';
  }

  @override
  Future<void> clearSession() async {
    await sharedPreferences.remove(AppConstants.userIdKey);
    await sharedPreferences.remove(AppConstants.userNameKey);
  }
}

// Using Random Auth localy
class SqlAuthRepo extends AuthRepository {
  final Database _db;

  SqlAuthRepo({
    required Database database,
    required super.errorHandler,
    required super.sharedPreferences,
  }) : _db = database;

  @override
  Future<AppResponse> deleteAccount() async {
    try {
      return AppResponse.withSuccess();
    } catch (e) {
      return AppResponse.withError();
    }
  }

  @override
  Future<AppResponse> login(LoginRequestModel loginRequestModel) async {
    try {
      await _db.insert(
        'Auth',
        loginRequestModel.toMap(),
      );

      AppLog.logValue(loginRequestModel.id);

      return AppResponse.withSuccess(
        data: {
          'id': loginRequestModel.id,
        },
      );
    } catch (e) {
      return AppResponse.withError(
        message: errorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<AppResponse> logout() async {
    try {
      await _db.delete(
        'Auth',
      );

      return AppResponse.withSuccess();
    } catch (e) {
      return AppResponse.withError(
        message: errorHandler.getErrorMessage(e),
      );
    }
  }

  @override
  Future<AppResponse> register() async {
    try {
      return AppResponse.withSuccess();
    } catch (e) {
      return AppResponse.withError();
    }
  }

  @override
  bool getLoginStatus() {
    return sharedPreferences.getBool(AppConstants.isLoggedInKey) ?? false;
  }

  @override
  Future<void> setLoginStatus(bool status) async {
    await sharedPreferences.setBool(AppConstants.isLoggedInKey, status);
  }

  @override
  Future<void> setName(String name) async {
    await sharedPreferences.setString(AppConstants.userNameKey, name);
  }

  @override
  Future<void> setUserId(String userId) async {
    await sharedPreferences.setString(AppConstants.userIdKey, userId);
  }

  @override
  String getName() {
    return sharedPreferences.getString(AppConstants.userNameKey) ?? '';
  }

  @override
  String getUserId() {
    return sharedPreferences.getString(AppConstants.userIdKey) ?? '';
  }

  @override
  Future<void> clearSession() async {
    await sharedPreferences.remove(AppConstants.userIdKey);
    await sharedPreferences.remove(AppConstants.userNameKey);
  }
}
