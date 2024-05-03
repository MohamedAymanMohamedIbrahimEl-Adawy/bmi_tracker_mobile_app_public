import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../data/constants/constants.dart';
import '../../../../services/contact_us/contact_us.dart';
import '../../../../services/theme/app_colors.dart';

class CompanyCopyrigths extends StatelessWidget {
  const CompanyCopyrigths({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: InkWell(
        onTap: () async {
          ContactUs.openUrl(
            AppConstants.websiteUrl,
          );
        },
        highlightColor: Theme.of(context).scaffoldBackgroundColor,
        hoverColor: Theme.of(context).scaffoldBackgroundColor,
        splashColor: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: AppColors.scafoldBackgroundColorLight2,
            ),
            borderRadius: BorderRadius.circular(35),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.copyright,
                color: Theme.of(context).colorScheme.primary,
                size: 17,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                'By AG DEVELOPMENT',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
