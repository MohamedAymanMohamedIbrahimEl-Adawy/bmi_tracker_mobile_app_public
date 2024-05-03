import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/constants/constants.dart';

// Contact Us class
class ContactUs {
  static void openUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  static Future<void> openFacebook() async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/${AppConstants.fbPageId}';
    } else {
      fbProtocolUrl = 'fb://page/${AppConstants.fbPageId}';
    }

    try {
      Uri fbBundleUri = Uri.parse(fbProtocolUrl);
      var canLaunchNatively = await canLaunchUrl(fbBundleUri);

      if (canLaunchNatively) {
        launchUrl(fbBundleUri);
      } else {
        await launchUrl(
          Uri.parse(AppConstants.fbFallbackUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // Handle this as you prefer
    }
  }

  static void sendEmail() async {
    final mailtoLink = Mailto(
      to: [AppConstants.email],
      subject: AppConstants.appName,
      body: AppConstants.supportMessage,
    );
    openUrl(mailtoLink.toString());
  }

  static void openWhatsAppUsingUrl(
      {required String phoneNumber, required String message}) async {
    if (kDebugMode) {
      print('phoneNumber == $phoneNumber');
    }

    final String url4 = "https://wa.me/$phoneNumber?text=$message";
    final String url5 = "whatsapp://send?phone=$phoneNumber&text=$message";

    try {
      openUrl(url5);
      if (kDebugMode) {
        print('working == url5');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      try {
        openUrl(url4);
        if (kDebugMode) {
          print('working == url4');
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        try {
          String encodedUrl4 = Uri.encodeFull(url4);
          openUrl(encodedUrl4);
          if (kDebugMode) {
            print('working == url4 encoded');
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    }
  }

  static void showContactUs(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              25,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              ContactItem(
                function: () {
                  sendEmail();
                },
                iconData: FontAwesomeIcons.envelope,
              ),
              ContactItem(
                function: () {
                  openUrl(
                    AppConstants.phoneCallUrll,
                  );
                },
                iconData: FontAwesomeIcons.phone,
              ),
            ],
          ),
        );
      },
    );
  }

  static void showTryApp({
    required BuildContext context,
    required String googlePlayUrl,
    required String appStoreUrl,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              25,
            ),
          ),
          content: Row(
            mainAxisAlignment: appStoreUrl.isEmpty || googlePlayUrl.isEmpty
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              appStoreUrl.isEmpty
                  ? const SizedBox()
                  : ContactItem(
                      function: () {
                        openUrl(
                          appStoreUrl,
                        );
                      },
                      iconData: FontAwesomeIcons.appStore,
                    ),
              googlePlayUrl.isEmpty
                  ? const SizedBox()
                  : ContactItem(
                      function: () {
                        openUrl(
                          googlePlayUrl,
                        );
                      },
                      iconData: FontAwesomeIcons.googlePlay,
                    ),
            ],
          ),
        );
      },
    );
  }

  static void showSocialMedia(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              25,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              ContactItem(
                function: () {
                  openFacebook();
                },
                iconData: FontAwesomeIcons.facebook,
              ),
              ContactItem(
                function: () {
                  openUrl(
                    AppConstants.instgram,
                  );
                },
                iconData: FontAwesomeIcons.instagram,
              ),
              ContactItem(
                function: () {
                  openWhatsAppUsingUrl(
                    phoneNumber: AppConstants.phoneNumber,
                    message: "ContactUs",
                  );
                },
                iconData: FontAwesomeIcons.whatsapp,
              ),
              // ContactItem(
              //   function: () {
              //     openUrl(
              //       AppConstants.telegram,
              //     );
              //   },
              //   iconData: FontAwesomeIcons.telegram,
              // ),
              // ContactItem(
              //   function: () {
              //     openUrl(
              //       AppConstants.tiktok,
              //     );
              //   },
              //   iconData: FontAwesomeIcons.tiktok,
              // ),
            ],
          ),
        );
      },
    );
  }
}

class ContactItem extends StatelessWidget {
  final Function() function;
  final IconData iconData;
  const ContactItem(
      {super.key, required this.function, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      radius: 24,
      child: Center(
        child: IconButton(
          icon: Icon(
            iconData,
            size: 26,
            color: Colors.white,
          ),
          onPressed: function,
        ),
      ),
    );
  }
}
