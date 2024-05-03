import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final Function() function;
  final String title;
  final String? subTitle;
  final IconData iconData;
  const DrawerItem({
    super.key,
    required this.function,
    required this.title,
    required this.iconData,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 30,
        left: 16,
        right: 16,
      ),
      child: GestureDetector(
        onTap: () async {
          function();
        },
        child: Row(
          children: [
            Icon(
              iconData,
              color: Theme.of(context).colorScheme.secondary,
              size: 20,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).primaryTextTheme.titleSmall,
                ),
                subTitle == null
                    ? Container()
                    : Text(
                        subTitle!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
