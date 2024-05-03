import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../../../services/app_store/app_store_handler.dart';
import '../../../../../services/deep_links/app_deep_links.dart';
import '../../../../../services/notifications/notifications_services.dart';
import '../../../add_bmi/screen/add_bmi_screen.dart';
import '../../../drawer/screen/drawer_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../Store/Screen/store_screen.dart';
import '../Widgets/bottom_nav_bar.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  const TabsScreen({
    super.key,
  });

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> tabs = [
    const HomeScreen(),
    const StoreScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Init notifications
    NotificationsServices().init();
    // Init Deep links
    AppLinksHandler.initUniLinks();
    // Check if there is new version available
    AppStoreHandler.checkForUpdate(Get.context!);
    // Show rate app if available
    AppStoreHandler.rateApp();
  }

  int _selectedIndex = 0;
  void onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        title: Text(
          'AG DEVELOPMENT',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddBmiScreen.routeName);
            },
            icon: Icon(
              Icons.add_box,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          fillColor: Colors.transparent,
          child: child,
        ),
        duration: const Duration(milliseconds: 800),
        child: tabs[_selectedIndex],
      )),
      extendBody: true, //<------like this
      bottomNavigationBar: MyBottomNavBar2(
        initialIndex: _selectedIndex,
        onTap: onTap,
      ),
    );
  }
}
