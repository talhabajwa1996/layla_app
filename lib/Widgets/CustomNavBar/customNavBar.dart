import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:layla_app_dev/AppTheme/fontSizes.dart';
import 'package:layla_app_dev/Controllers/DashboardController/dashboardController.dart';
import 'package:layla_app_dev/Controllers/SearchBarController/searchBarController.dart';
import 'package:provider/provider.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../AppTheme/ColorConstants.dart';
import '../../Controllers/AuthController/AuthController.dart';
import '../../Utils/Constants/RouteConstants.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthController, DashboardController, SearchBarController>(builder: (context,authController, dashboardProvider,searchBarProvider, child) {
      return CupertinoTabBar(
        currentIndex: dashboardProvider.selectedTabIndex,
        backgroundColor: ColorConstants.transparent,
        height: 70.sp,
        border: const Border(),
        items: [
          BottomNavigationBarItem(
              icon: Icon(dashboardProvider.selectedTabIndex == 0 ? CupertinoIcons.house_fill : CupertinoIcons.home)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search)),
          BottomNavigationBarItem(
              icon: Text("MENU", style: GoogleFonts.sofiaSansCondensed(
                textStyle: TextStyle(
                    fontSize: dashboardProvider.selectedTabIndex == 2 ? FontSizes.normalText1: FontSizes.smallText,
                    fontWeight: dashboardProvider.selectedTabIndex == 2 ? FontWeight.w900: FontWeight.w500,
                    color: ColorConstants.textColorGrey,
                    height: 1.25
                )
              ),)),
          BottomNavigationBarItem(
              icon: Icon(dashboardProvider.selectedTabIndex == 3 ? CupertinoIcons.person_fill : CupertinoIcons.person)),
          BottomNavigationBarItem(
              icon: Icon(dashboardProvider.selectedTabIndex == 4 ? CupertinoIcons.bag_fill : CupertinoIcons.bag)),
        ],
        onTap: (index) {
          dashboardProvider.setTabIndex = index;
          if(index != 1){
            searchBarProvider.setSearching = false;
            if(index == 3){
              authController.isUserLoggedIn
                  ? Navigator.pushNamed(context, RouteConstants.settings)
                  : Navigator.pushNamed(context, RouteConstants.auth);
            }
          }
        },
      );
    });
  }

  Widget navBarIcon(String asset, Color? svgColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.sp),
      child: WebsafeSvg.asset(
        asset,
        width: 18.sp,
        height: 18.sp,
        alignment: Alignment.center,
        colorFilter: ColorFilter.mode(
          svgColor!,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
