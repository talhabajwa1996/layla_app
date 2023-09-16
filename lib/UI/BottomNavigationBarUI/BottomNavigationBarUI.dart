import 'package:flutter/material.dart';
import 'package:layla_app_dev/Controllers/HomeController/HomeController.dart';
import 'package:layla_app_dev/Routes/CartNavigator.dart';
import 'package:layla_app_dev/Routes/FavouritesNavigator.dart';
import 'package:layla_app_dev/Routes/HomeNavigator.dart';
import 'package:layla_app_dev/Routes/MenuNavigator.dart';
import 'package:layla_app_dev/Routes/ProfileNavigator.dart';
import 'package:layla_app_dev/Utils/Constants/AppIcons.dart';
import 'package:provider/provider.dart';
import '../../Utils/Constants/ColorConstants.dart';

class BottomNavigationBarUI extends StatefulWidget {
  const BottomNavigationBarUI({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarUI> createState() => _BottomNavigationBarUIState();
}

class _BottomNavigationBarUIState extends State<BottomNavigationBarUI>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  @override
  void initState() {
    Provider.of<BottomBarController>(context, listen: false).initController =
        TabController(vsync: this, length: 5, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<BottomBarController>(context).disposeController();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomBarController>(
        builder: (context, bottomBarController, child) {
      TabController tabController = bottomBarController.tabController;
      return Scaffold(
        backgroundColor: ColorConstants.white,
        resizeToAvoidBottomInset: false,
        body: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeNavigator(bottomBarController.bottomBarNavigationKeys[0]),
            FavouritesNavigator(bottomBarController.bottomBarNavigationKeys[1]),
            MenuNavigator(bottomBarController.bottomBarNavigationKeys[2]),
            ProfileNavigator(bottomBarController.bottomBarNavigationKeys[3]),
            CartNavigator(bottomBarController.bottomBarNavigationKeys[4]),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: BottomAppBar(
            color: ColorConstants.white,
            shape: const CircularNotchedRectangle(),
            child: TabBar(
              controller: tabController,
              onTap: (index) {
                if (bottomBarController
                        .bottomBarNavigationKeys[tabController.index]
                        .currentState !=
                    null) {
                  bottomBarController
                      .bottomBarNavigationKeys[tabController.index]
                      .currentState!
                      .popUntil((r) => r.isFirst);
                }
              },
              indicator: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.transparent, width: 0),
                ),
              ),
              tabs: [
                buildTab(AppIcons.home),
                buildTab(AppIcons.favourite),
                const Text(
                  'MENU',
                  style: TextStyle(fontSize: 16),
                ),
                buildTab(AppIcons.profile),
                buildTab(AppIcons.cart),
              ],
              labelPadding: const EdgeInsets.all(0.0),
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 5.0),
              labelColor: ColorConstants.primaryColor,
              unselectedLabelColor: ColorConstants.black,
              splashBorderRadius: BorderRadius.circular(100),
              unselectedLabelStyle: const TextStyle(
                  color: ColorConstants.white, fontWeight: FontWeight.w500),
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ),
      );
    });
  }

  Widget buildTab(IconData icon) {
    return Icon(icon);
  }
}
