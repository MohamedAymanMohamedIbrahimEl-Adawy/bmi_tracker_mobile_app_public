import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../../../../../services/contact_us/contact_us.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            AppCard(
              appTitle: 'Petberry',
              image: 'assets/images/petberry.jpg',
              appDescription: 'It\'s a single vendor e-commerce mobile app',
              appStoreUrl:
                  'https://apps.apple.com/us/app/petberry/id6473836274?platform=iphone',
              googlePlayUrl:
                  'https://play.google.com/store/apps/details?id=com.genix.petberry',
            ),
            AppCard(
              appTitle: 'W3d (الواعد)',
              image: 'assets/images/w3d.png',
              appDescription: 'Multi vendors e-Commerce mobile app',
              appStoreUrl:
                  'https://apps.apple.com/sa/app/%D8%A7%D9%84%D9%88%D8%A7%D8%B9%D8%AF/id1561982511?platform=iphone',
              googlePlayUrl:
                  'https://play.google.com/store/apps/details?id=com.moadawy.W3d',
            ),
            AppCard(
              appTitle: 'Home Hive',
              image: 'assets/images/home_hive.png',
              appDescription:
                  'It\'s an e-commerce mobile app for kitchen supplies',
              appStoreUrl:
                  'https://apps.apple.com/us/app/home-hive-egypt/id6478495668?platform=iphone',
              googlePlayUrl:
                  'https://play.google.com/store/apps/details?id=com.genix.home.hive',
            ),
            AppCard(
              appTitle: 'Genix Marketplace',
              image: 'assets/images/genix_marketplace.png',
              appDescription: 'It\'s an e-commerce mobile app',
              appStoreUrl: '',
              googlePlayUrl:
                  'https://play.google.com/store/apps/details?id=com.genix.marketplace',
            ),
            AppCard(
              appTitle: 'QR Scanner & Wifi Connector',
              image: 'assets/images/ag_wide2.png',
              appDescription:
                  'It\'s a free and smart QR, Barcode and Wifi scanner and Wifi connector',
              appStoreUrl: '',
              googlePlayUrl:
                  'https://play.google.com/store/apps/details?id=com.ag.qrbarcodescanner',
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final String appTitle;
  final String appDescription;
  final String googlePlayUrl;
  final String appStoreUrl;
  final String image;
  const AppCard({
    super.key,
    required this.appTitle,
    required this.appDescription,
    required this.googlePlayUrl,
    required this.appStoreUrl,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.getShadeColor(
              shadeValue: 6,
            ),
        borderRadius: BorderRadius.circular(25),
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  appTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Text(
                  appDescription,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              ContactUs.showTryApp(
                context: context,
                googlePlayUrl: googlePlayUrl,
                appStoreUrl: appStoreUrl,
              );
            },
            highlightColor: Theme.of(context)
                .scaffoldBackgroundColor
                .getShadeColor(shadeValue: 14),
            splashColor: Theme.of(context).scaffoldBackgroundColor
              ..getShadeColor(shadeValue: 14),
            child: Text(
              'tryItNow'.tr(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
