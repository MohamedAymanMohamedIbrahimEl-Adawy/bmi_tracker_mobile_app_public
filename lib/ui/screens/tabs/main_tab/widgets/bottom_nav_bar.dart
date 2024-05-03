import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyBottomNavBar2 extends StatelessWidget {
  final int initialIndex;
  final Function(int) onTap;
  const MyBottomNavBar2({
    super.key,
    required this.initialIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final NotchBottomBarController notchBottomBarController =
        NotchBottomBarController(index: initialIndex);

    return AnimatedNotchBottomBar(
      color: Theme.of(context)
          .scaffoldBackgroundColor
          .getShadeColor(shadeValue: 20),

      showLabel: false,
      textOverflow: TextOverflow.clip,
      maxLine: 1,
      shadowElevation: 5,

      // notchShader: const SweepGradient(
      //   startAngle: 0,
      //   endAngle: pi / 2,
      //   colors: [Colors.red, Colors.green, Colors.orange],
      //   tileMode: TileMode.mirror,
      // ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
      notchColor: Theme.of(context)
          .scaffoldBackgroundColor
          .getShadeColor(shadeValue: 20),

      /// restart app if you change removeMargins
      removeMargins: false,
      bottomBarWidth: 500,
      showShadow: false,
      durationInMilliSeconds: 300,

      itemLabelStyle: const TextStyle(fontSize: 10),

      elevation: 1,
      kIconSize: 20,
      kBottomRadius: 28.0,
      bottomBarItems: [
        BottomBarItem(
          inActiveItem: Icon(
            FontAwesomeIcons.house,
            size: 22,
            color: Theme.of(context).colorScheme.secondary,
          ),
          activeItem: Icon(
            FontAwesomeIcons.house,
            size: 22,
            color: Theme.of(context).colorScheme.secondary,
          ),
          itemLabel: 'home'.tr(),
        ),

        ///svg item
        BottomBarItem(
          inActiveItem: Icon(
            FontAwesomeIcons.store,
            size: 22,
            color: Theme.of(context).colorScheme.secondary,
          ),
          activeItem: Icon(
            FontAwesomeIcons.store,
            size: 22,
            color: Theme.of(context).colorScheme.secondary,
          ),
          itemLabel: "appsGallery".tr(),
        ),
      ],
      notchBottomBarController: notchBottomBarController,
      onTap: onTap,
    );
  }
}
