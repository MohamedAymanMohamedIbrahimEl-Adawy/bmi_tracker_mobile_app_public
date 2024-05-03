import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../data/constants/constants.dart';
import '../../../../providers/auth/auth_provider.dart';
import '../../../../providers/bmi/bmi_provider.dart';
import '../../../../services/app_store/app_store_handler.dart';
import '../../../../services/contact_us/contact_us.dart';
import '../../../../services/localization/app_localization.dart';
import '../widgets/company_copyrigths.dart';
import '../widgets/drawer_item.dart';
import '../widgets/theme_switcher.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Drawer(
      width: size.width * 0.8,
      backgroundColor: AdaptiveTheme.of(context).mode.isDark
          ? Theme.of(context).scaffoldBackgroundColor
          : Theme.of(context).primaryColorLight.getShadeColor(shadeValue: 34),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -120,
            left: -170,
            child: CircleAvatar(
              radius: size.width * 0.65,
              backgroundColor: AdaptiveTheme.of(context).mode.isDark
                  ? Theme.of(context)
                      .scaffoldBackgroundColor
                      .getShadeColor(shadeValue: 6)
                  : Theme.of(context)
                      .primaryColorLight
                      .getShadeColor(shadeValue: 28),
            ),
          ),
          Positioned(
            top: -120,
            left: -170,
            child: CircleAvatar(
              radius: size.width * 0.59,
              backgroundColor: AdaptiveTheme.of(context).mode.isDark
                  ? Theme.of(context)
                      .scaffoldBackgroundColor
                      .getShadeColor(shadeValue: 10)
                  : Theme.of(context)
                      .primaryColorLight
                      .getShadeColor(shadeValue: 22),
            ),
          ),
          Positioned(
            top: -120,
            left: -170,
            child: CircleAvatar(
              radius: size.width * 0.53,
              backgroundColor: AdaptiveTheme.of(context).mode.isDark
                  ? Theme.of(context)
                      .scaffoldBackgroundColor
                      .getShadeColor(shadeValue: 14)
                  : Theme.of(context)
                      .primaryColorLight
                      .getShadeColor(shadeValue: 16),
            ),
          ),
          Positioned(
            top: size.height * .10,
            left: 20,
            child: SvgPicture.asset(
              'assets/images/logo_title_white.svg',
              width: 140,
              fit: BoxFit.contain,
            ),
          ),
          const DrawerItems(),
        ],
      ),
    );
  }
}

class DrawerItems extends StatelessWidget {
  const DrawerItems({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: size.height * .3,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DrawerItem(
                  function: () {
                    Navigator.of(context).pop();
                  },
                  title: "home".tr(),
                  iconData: FontAwesomeIcons.house,
                ),
                DrawerItem(
                  function: () async {
                    await Provider.of<BmiProvider>(context, listen: false)
                        .deleteAll();
                  },
                  title: "clearAllRecords".tr(),
                  iconData: Icons.delete_forever,
                ),
                DrawerItem(
                  function: () {
                    ContactUs.showContactUs(context);
                  },
                  title: "contactUs".tr(),
                  iconData: FontAwesomeIcons.headset,
                ),
                DrawerItem(
                  function: () {
                    ContactUs.showSocialMedia(context);
                  },
                  title: "social".tr(),
                  iconData: FontAwesomeIcons.thumbsUp,
                ),
                DrawerItem(
                  function: () async {
                    AppLocalization.showChangeLanguageDialog(context);
                  },
                  title: 'language'.tr(),
                  iconData: FontAwesomeIcons.language,
                ),
                DrawerItem(
                  function: () {
                    ContactUs.openUrl(
                      AppConstants.websiteUrl,
                    );
                  },
                  title: 'aboutUs'.tr(),
                  iconData: FontAwesomeIcons.info,
                ),
                DrawerItem(
                  function: () {
                    ContactUs.openUrl(
                      AppConstants.privacyPolicy,
                    );
                  },
                  title: 'privacyPolicy'.tr(),
                  iconData: Icons.privacy_tip_outlined,
                ),
                DrawerItem(
                  function: () {
                    AppStoreHandler.openStore();
                  },
                  title: "rateApp".tr(),
                  iconData: FontAwesomeIcons.star,
                ),
                DrawerItem(
                  function: () {
                    AppStoreHandler.shareApp(context);
                  },
                  title: 'shareApp'.tr(),
                  iconData: FontAwesomeIcons.share,
                ),
                DrawerItem(
                  function: () async {
                    await Provider.of<AuthProvider>(context, listen: false)
                        .logout();
                  },
                  title: "logout".tr(),
                  iconData: FontAwesomeIcons.arrowRightFromBracket,
                ),
              ],
            ),
          ),
        ),
        const ThemeSwitcher(),
        const CompanyCopyrigths(),
      ],
    );
  }
}
