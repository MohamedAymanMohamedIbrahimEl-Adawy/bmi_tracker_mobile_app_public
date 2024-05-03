import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppLocalization {
  static const List<Locale> _spportedLocales = [
    Locale('en', "US"),
    Locale('ar', "DZ"),
    Locale("fr", "FR"),
  ];
  static const Locale _fallbackLocale = Locale('en', "US");
  static const Locale _startLocale = Locale('en', "US");

  static List<Locale> get getSupportedLocales {
    return [..._spportedLocales];
  }

  static Locale get fallbackLocale {
    return _fallbackLocale;
  }

  static Locale get startLocale {
    return _startLocale;
  }

  static Future<dynamic> showChangeLanguageDialog(BuildContext context) async {
    Locale locale;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              25,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 8,
                ),
                child: Text(
                  'language'.tr(),
                  textScaler: const TextScaler.linear(1),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                      ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    minimumSize: const Size(205, 20),
                  ),
                  onPressed: () async {
                    locale = const Locale("ar", "DZ");
                    await context.setLocale(locale);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'arabicLang'.tr(),
                      textScaler: const TextScaler.linear(1),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    minimumSize: const Size(205, 20),
                  ),
                  onPressed: () async {
                    locale = const Locale("en", "US");
                    await context.setLocale(locale);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'englishLang'.tr(),
                      textScaler: const TextScaler.linear(1),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    minimumSize: const Size(205, 20),
                  ),
                  onPressed: () async {
                    locale = const Locale("fr", "FR");
                    await context.setLocale(locale);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'franceLang'.tr(),
                      textScaler: const TextScaler.linear(1),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}
