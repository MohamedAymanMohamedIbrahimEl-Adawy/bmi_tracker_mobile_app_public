import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../data/models/login/login_request_model.dart';
import '../../data/models/response/app_response.dart';
import '../../data/repositories/auth/auth_repo.dart';
import '../../main.dart';
import '../../services/snacks/app_snacks.dart';
import '../../ui/screens/auth/login/screen/login_screen.dart';
import '../../ui/screens/tabs/main_tab/screen/tabs_screen.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider({required AuthRepository authRepository})
      : _authRepository = authRepository;
  bool _isLoading = false;
  Future<void> login(LoginRequestModel loginRequestModel) async {
    if (_isLoading) {
      return;
    }
    late final AppResponse appResponse;
    _isLoading = true;

    appResponse = await _authRepository.login(loginRequestModel);
    _isLoading = false;
    if (appResponse.hasError) {
      AppSnacks.showTopSnackBar(
        context: Get.context!,
        title: 'alert'.tr(),
        body: appResponse.message!,
      );
    } else {
      AppSnacks.showTopSnackBar(
        context: Get.context!,
        title: 'nice'.tr(),
        body: 'Logged in successfully'.tr(),
      );
      await _authRepository.setLoginStatus(true);
      await _authRepository.setUserId(appResponse.data?['id']);
      Future.delayed(const Duration(seconds: 2)).then((value) =>
          Navigator.of(Get.context!)
              .pushReplacementNamed(TabsScreen.routeName));
    }
  }

  Future<void> logout() async {
    if (_isLoading) {
      return;
    }
    late final AppResponse appResponse;
    _isLoading = true;

    appResponse = await _authRepository.logout();
    _isLoading = false;
    if (appResponse.hasError) {
      AppSnacks.showTopSnackBar(
        context: Get.context!,
        title: 'alert'.tr(),
        body: appResponse.message!,
      );
    } else {
      AppSnacks.showTopSnackBar(
        context: Get.context!,
        title: 'nice'.tr(),
        body: 'Logged out successfully'.tr(),
      );
      await _authRepository.setLoginStatus(false);
      await _authRepository.clearSession();
      Navigator.of(Get.context!).pushNamedAndRemoveUntil(
        LoginScreen.routeName,
        (route) => route.settings.name == LoginScreen.routeName,
      );
    }
  }

  bool getLoginStatus() {
    return _authRepository.getLoginStatus();
  }

  String get getUserId {
    return _authRepository.getUserId();
  }
}
