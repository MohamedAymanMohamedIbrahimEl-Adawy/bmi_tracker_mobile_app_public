import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  late bool isLight = true;
  @override
  void initState() {
    super.initState();
    AdaptiveTheme.getThemeMode().then((value) => setState(() {
          isLight = value == AdaptiveThemeMode.light;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .scaffoldBackgroundColor
            .getShadeColor(shadeValue: 6),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: isLight
                  ? Theme.of(context)
                      .scaffoldBackgroundColor
                      .getShadeColor(shadeValue: 12)
                  : Theme.of(context)
                      .scaffoldBackgroundColor
                      .getShadeColor(shadeValue: 6),
            ),
            child: InkWell(
              onTap: () {
                // AdaptiveTheme.of(context).setLight();

                isLight = true;
                setState(() {});
              },
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.sun,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'light'.tr(),
                    style: Theme.of(context)
                        .primaryTextTheme
                        .titleSmall
                        ?.copyWith(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: isLight
                  ? Theme.of(context)
                      .scaffoldBackgroundColor
                      .getShadeColor(shadeValue: 6)
                  : Theme.of(context)
                      .scaffoldBackgroundColor
                      .getShadeColor(shadeValue: 12),
            ),
            child: InkWell(
              onTap: () {
                // AdaptiveTheme.of(context).setDark();

                isLight = false;
                setState(() {});
              },
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.moon,
                    color: Colors.black,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'dark'.tr(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
