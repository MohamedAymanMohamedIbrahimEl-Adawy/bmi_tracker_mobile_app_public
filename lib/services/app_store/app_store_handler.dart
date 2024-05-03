import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../serivce_locator.dart';
import '../alerts/app_alerts.dart';
import '../log/app_log.dart';
import '../../data/constants/constants.dart';

class AppStoreHandler {
  static void showUpdateWithoutAlert() {
    if (Platform.isAndroid) {
      InAppUpdate.checkForUpdate().then((updateInfo) {
        AppLog.logValue(updateInfo.updateAvailability);

        if (updateInfo.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          //Perform flexible update
          InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
            if (appUpdateResult == AppUpdateResult.success) {
              //App Update successful
              InAppUpdate.completeFlexibleUpdate();
            }
          });
        }
      });
    } else if (Platform.isIOS) {
      NewVersionPlus newVersion = NewVersionPlus();
      newVersion.getVersionStatus().then((status) {
        bool isAvailableUpdate = status?.canUpdate ?? false;
        if (isAvailableUpdate) {
          final InAppReview inAppReview = InAppReview.instance;
          inAppReview.openStoreListing();
        }
      });
    } else {
      //
    }
  }

  static void checkForUpdate(BuildContext context) {
    bool isAvailableUpdate = false;
    if (kDebugMode) {
      return;
    }

    if (Platform.isAndroid) {
      InAppUpdate.checkForUpdate().then((updateInfo) {
        AppLog.logValue(updateInfo.updateAvailability);

        if (updateInfo.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          isAvailableUpdate = true;
          AppLog.logValue(updateInfo.immediateUpdateAllowed);
          AppLog.logValue(updateInfo.flexibleUpdateAllowed);
          AppAlerts.showAlertYesOrNo(
            context: context,
            title: 'anUpdateAvailable',
            actionButtonTitleYes: 'update',
            actionButtonTitleNo: 'later',
          ).then((value) {
            if (value == true) {
              //Perform flexible update
              InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
                if (appUpdateResult == AppUpdateResult.success) {
                  //App Update successful
                  InAppUpdate.completeFlexibleUpdate();
                }
              });
              // //Logic to perform flexiable or immediate update.
              // if (updateInfo.immediateUpdateAllowed) {
              //   // Perform immediate update
              //   InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
              //     if (appUpdateResult == AppUpdateResult.success) {
              //       //App Update successful
              //     }
              //   });
              // } else if (updateInfo.flexibleUpdateAllowed) {
              //   //Perform flexible update
              //   InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
              //     if (appUpdateResult == AppUpdateResult.success) {
              //       //App Update successful
              //       InAppUpdate.completeFlexibleUpdate();
              //     }
              //   });
              // }
            }
          });
        }
      });
    } else if (Platform.isIOS) {
      NewVersionPlus newVersion = NewVersionPlus();
      newVersion.getVersionStatus().then((status) {
        isAvailableUpdate = status?.canUpdate ?? false;
        if (isAvailableUpdate) {
          AppAlerts.showAlertYesOrNo(
            context: context,
            title: 'anUpdateAvailable',
            actionButtonTitleYes: 'update',
            actionButtonTitleNo: 'later',
          ).then((value) {
            if (value == true) {
              openStore();
            }
          });
        }
      });
    } else {
      //
    }
  }

  static void shareApp(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox;
    await Share.share(
      AppConstants.shareAppUrl,
      subject: 'Share App',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  static void openStore() {
    final InAppReview inAppReview = InAppReview.instance;
    inAppReview.openStoreListing(
      appStoreId: AppConstants.andriodPackageId,
    );
  }

  static void rateApp() async {
    String? dateFirstTimeOpen = serviceLocator<SharedPreferences>()
        .getString(AppConstants.dateFirstTimeOpenKey);
    if (dateFirstTimeOpen == null) {
      serviceLocator<SharedPreferences>().setString(
          AppConstants.dateFirstTimeOpenKey, DateTime.now().toIso8601String());
    } else if (DateTime.parse(dateFirstTimeOpen)
        .add(const Duration(days: 30))
        .isBefore(DateTime.now())) {
      final InAppReview inAppReview = InAppReview.instance;
      inAppReview.isAvailable().then((value) {
        if (value) {
          inAppReview.requestReview();
        }
      });
    }
  }
}
